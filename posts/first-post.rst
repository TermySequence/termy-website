.. Copyright © 2018 TermySequence LLC
.. SPDX-License-Identifier: CC-BY-SA-4.0

.. post:: 12 May 2018
   :tags: article

First Post
==========

`TermySequence <https://termysequence.io>`_ has released! As a terminal emulation system, TermySequence is a new entry in a crowded field. This post explains the design goals of the project and what makes it different from other terminal emulators.

**TL;DR**: Give TermySequence a try. It has features you may find compelling.

**Goal #1: An integrated multiplexer.** TermySequence is actually a :doc:`protocol specification <td:protocol>` for a terminal emulator multiplexer, :doc:`termy-server <td:server>`. A TermySequence client is merely a front-end to the multiplexer, which handles all emulation. This has a few benefits:

First, users don't need to climb the learning curve of a traditional multiplexer. This includes separate key bindings, configuration, invocation, concepts, and terminology, all of which can be daunting for a new user. With TermySequence, the multiplexer is fully integrated with the client, which "knows" about all the multiplexer's terminals. The user only needs to learn the client itself; the multiplexer comes "for free."

Second, it eliminates the additional layer of emulation that a traditional multiplexer puts between the user and the terminal software. This extra layer can and does cause problems with escape sequences and character alignment, which are often "fixed" using :envvar:`TERM` hacks in shell scripts. It's a pain point, which can be addressed at least in part\ [#]_ by making the multiplexer the one and only emulator in the system.

Note that the goal is for the multiplexer to be *integrated*, not for it to be *transparent*. It's important that the user be aware of the multiplexer and the implications of its presence in the system.

**Goal #2: A multiplexer that recognizes itself.** Terminals are used more than ever to interact with remote servers and containers. These systems are often two, three, or more hops distant, where each "hop" involves a program such as :program:`ssh`, :program:`kubectl`, :program:`docker`, or :program:`machinectl` which bootstraps a shell in a remote environment. Even switching users with :program:`su` is really a "connection" in this sense.

A goal of TermySequence is to provide a multiplexer that recognizes itself executing across a connection opened using standard tools normally used to get a shell. With a bit of protocol engineering, it's possible to accomplish this. Once the multiplexers are in communication, the downstream multiplexer can "proxy" the upstream multiplexer and all of its terminals. The connection is no longer just "inside a terminal." Now the client is aware of the connection, the upstream multiplexer, and all its terminals. They can be treated as first-class objects displayed to the user.

Since each multiplexer can proxy outbound connections, the scheme is :term:`recursive <td:connection chaining>`. A multiplexer connected across multiple hops, such as through a jump box or from a remote host into a container, appears to a client as any other multiplexer. Each client sees the entire tree of multiplexers upstream of it. This leads to the next goal:

**Goal #3: One connection is all you need.** Making a connection to a remote system is a lot of work: processes executed, file handles opened, network packets round-tripped, authentication performed. While some tools such as :program:`ssh` have ways of reusing connections, there's a sure-fire way to save time and resources in this area: open a *single connection* and utilize it to the maximum extent possible.

We've all run :program:`ssh` three times to get three terminals on a remote host, or :program:`su` three times to get local root shells. A multiplexer makes it possible to create as many terminals as desired over a single connection. An integrated multiplexer makes it possible to arrange them as tabs or windows just like local terminals. But it's possible to take connection reuse a lot further.

We can make our multiplexer and protocol do more than just terminals. Things like file `uploads <https://termysequence.io/doc/actions.html#UploadFile>`_ and `downloads <https://termysequence.io/doc/actions.html#DownloadFile>`_, remote file `mounts <https://termysequence.io/doc/actions.html#MountFile>`_ via FUSE, on-demand :doc:`port forwarding <td:dialogs/port-forwarding>`, and remote `command execution <https://termysequence.io/doc/actions.html#RunCommand>`_. We've already authenticated to the remote system and connected to the multiplexer. These other capabilities should just come for free, over the same connection used for terminals. And with a recursively connectable multiplexer, all of this works over multiple hops.

It's important to note that this concept can be useful even for local tasks. Ever become root with :program:`su` and then transfer files by hand using :file:`/tmp` and :program:`chown`? Or become root and forward port 443 to your development web server? These tasks can both be accomplished with TermySequence using a single :program:`su` or :program:`sudo` connection to root's multiplexer.

**Goal #4: A feature-rich client.** TermySequence clients can offer unique features based on the TermySequence protocol. It's also important for clients, or at least the exemplar client :doc:`qtermy <td:client-qt>`, to offer a variety of traditional features. `Split windows <https://termysequence.io/doc/actions.html#SplitViewHorizontal>`_, :doc:`terminal thumbnails <td:tools/terminals>`, :doc:`terminal program icons <td:dialogs/icon-rule-editor>`, settings :doc:`profiles <td:settings/profile>`, configurable :doc:`keymaps <td:settings/keymap>`, :doc:`alerts <td:settings/alert>`, :doc:`annotations <td:dialogs/create-annotation>`, `badges <https://termysequence.io/doc/settings/profile.html#Appearance/Badge>`_, :doc:`shell integration <td:shell-integration>`, :doc:`inline image display <td:man/download>`, command :doc:`history <td:tools/history>`, command :doc:`suggestions <td:tools/suggestions>`, :term:`input multiplexing <td:input multiplexing>`, color :doc:`themes <td:settings/theme>`, `screen capture <https://termysequence.io/doc/actions.html#SaveScreen>`_, per-row :ref:`modification times <td:timing-widget>`, `OSC 8 hyperlinks <https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda>`_, :ref:`presentation mode <td:global-presentation-mode>`, custom-rendered :term:`emoji <td:emoji>`, and more.

qtermy provides a :doc:`plugin system <td:plugins/index>` via an embedded `Chrome V8 <https://developers.google.com/v8/>`_ Javascript engine. Plugins can implement :doc:`custom actions <td:plugins/action>` using a rich API (still in development) which provides broad access to client internals including terminal state and contents. Plugins can also implement :doc:`semantic parsers <td:plugins/parser>` used to mark up terminal content with :term:`semantic regions <td:semantic region>`.

qtermy also provides collaboration features. Collaboration in TermySequence occurs when multiple clients connect to the same multiplexer. Terminal `ownership assignment <https://termysequence.io/doc/actions.html#TakeTerminalOwnership>`_, viewport scrolling which `follows <https://termysequence.io/doc/actions.html#ToggleTerminalFollowing>`_ the owner's position, and :ref:`sharing of remote font and color settings <td:profile-collaboration>` are some of the collaboration features offered.

**Goal #5: Easy to install. Easy to develop.** Because it's important for the termy-server multiplexer to be installed on servers and in containers, it has a very small dependency footprint. Here's the shared object dependency list of the :doc:`termy-server <td:man/server>` executable, in its entirety::

  linux-vdso.so.1
  libdl.so.2
  libuuid.so.1
  libstdc++.so.6
  libm.so.6
  libgcc_s.so.1
  libpthread.so.0
  libc.so.6
  ld-linux-x86-64.so.2

Systemd support adds ``libsystemd`` to that list. No other interpreters, scripting languages, runtimes, or libraries are required by the multiplexer. On the author's Fedora 28 system, the files in the termy-server `package <https://copr.fedorainfracloud.org/coprs/ewalsh/termysequence/>`_ total less than a megabyte on disk, including man pages and 17KB of GPL text. Also, aside from a bit of :doc:`systemd setup <td:systemd>`, the multiplexer is zero-configuration.

Finally, it's a goal of TermySequence to make it easier to :doc:`write <td:protocol/strategy>` new terminal applications. Instead of implementing a complex emulator state machine, a TermySequence client only needs to parse the protocol messages sent to it by the multiplexer. The protocol is designed so that clients can ignore the messages they don't care about; a client can start simple and gradually add support for more features.

.. rubric:: Footnotes

.. [#] To fully prevent character alignment issues, the multiplexer and client need to agree on the character encoding. The TermySequence protocol :doc:`specifies <td:protocol/unicode>` character widths and combining behavior, but the client must obey them, which may be difficult depending on the rendering libraries used.
