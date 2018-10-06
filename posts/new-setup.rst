.. Copyright © 2018 TermySequence LLC
.. SPDX-License-Identifier: CC-BY-SA-4.0

.. post:: 06 Oct 2018
   :tags: article

New Shell Integration Setup
===========================

If :doc:`shell integration <td:shell-integration>` stops working for you after the next release, run Setup Tasks from the Help menu to fix it.

Here's the backstory: TermySequence bundles a copy of the bash shell integration script from the `iTerm2 <https://iterm2.com>`_ project. Currently, the bash script is installed into :file:`/etc/profile.d`, the idea being that it will be sourced automatically without needing to modify anybody's dotfiles.

Unfortunately, experiments with different distributions have shown that this way of doing it is a lost cause. There are simply too many subtle variations between distribution login scripts. One distro sets :envvar:`PROMPT_COMMAND` after the script is sourced, breaking it. Another distro sources the script only during desktop login where it has no effect.

So the upcoming 1.1.4 release will switch to writing dotfiles like :file:`.bash_profile`. To accomplish this, the setup logic has been rewritten from the ground up. Here's a summary of the changes:

  * The bundled shell integration scripts will be installed into :file:`/usr/share/termy-server` instead of :file:`/etc/profile.d`. Downstream, subpackages will be removed and the scripts will be included in the main :program:`termy-server` package.

  * A new setup script :program:`termy-setup` will replace the current :doc:`termy-systemd-setup <td:man/systemd>`, subsuming its :doc:`functionality <td:systemd>` and also providing the logic to append shell integration code to user dotfiles.

  * A new Setup Tasks dialog wrapping :program:`termy-setup` will be added to :program:`qtermy`. It will be shown on first launch and will be accessible from the Help menu. The existing setup prompt will be removed.

All of this will hopefully result in a simpler and better setup experience going forward. Of course, it's also possible to skip setup entirely and install shell integration manually using the `upstream instructions <https://iterm2.com/shell_integration.html>`_.
