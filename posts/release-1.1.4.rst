.. Copyright © 2018 TermySequence LLC
.. SPDX-License-Identifier: CC-BY-SA-4.0

.. post:: 15 Oct 2018
   :tags: release

Release 1.1.4 Announcement
==========================

TermySequence 1.1.4 has :doc:`released </releases/index>`! Over the summer, much work was done in the area of dependencies and packaging with the goal of spreading TermySequence to more Linux distributions. Here are the major changes introduced in the 1.1.0 series up to this point:

  * Split :program:`termy-server` and :program:`qtermy` into separate source tarballs. This allows for separate releases of each program and also makes life easier for server-only packagers.
  * Added support for libfuse version 2 to support distributions that don't package libfuse version 3.
  * The Chrome V8 library is now bundled with :program:`qtermy` and built as a static library. With Fedora `dropping <https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/DI4Q5526MVI5KS7OG4PH37QFK6KCDAY2/>`_ its V8 package and other distros not having one to begin with, this is a necessary move.
  * The `termy-emoji <https://github.com/TermySequence/termy-emoji>`_ and `termy-icon-theme <https://github.com/TermySequence/termy-icon-theme>`_ subprojects are now bundled with :program:`qtermy` as well.
  * Added 8 new builtin color themes. Blog: :doc:`all-about-color-themes`.
  * Reworked the setup mechanism to source shell integration scripts from user dotfiles instead of :file:`/etc/profile.d`. Blog: :doc:`new-setup`.
  * Implemented a new way to update session environment variables. Blog: :doc:`session-environment`.
  * Added new plugin API to support the :doc:`Rotate Theme plugin <plugin-rotate-theme>`.
  * New binary packages for :ref:`install-ubuntu`, :ref:`install-opensuse`, and :ref:`install-arch` via `Open Build Service <https://build.opensuse.org/repositories/home:sigalrm>`_ with all packaging metadata available `here <https://github.com/TermySequence/termy-packaging>`_.
  * Various bug fixes.
