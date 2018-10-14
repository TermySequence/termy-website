.. Copyright © 2018 TermySequence LLC
.. SPDX-License-Identifier: CC-BY-SA-4.0

.. post:: 14 Oct 2018
   :tags: plugin

Featured Plugin: Rotate Theme
=============================

Today's plugin is a :doc:`custom action <td:plugins/action>`, RotateTheme. While there is a "Random Color Theme" action in the View menu, there was no way to rotate through the available color themes in order. New plugin API provided in the 1.1.0 release allows theme rotation to be implemented in Javascript.

The video rotates through the builtin themes that ship with :program:`qtermy` 1.1.1, including light and dark `Solarized <http://ethanschoonover.com/solarized>`_ themes and 8 custom themes by graphic designer `Katharine Scott <https://kgrayscott.com/>`_.

.. raw:: html

   <video controls src="../_static/rotate-theme.webm"></video>

The JavaScript source for the plugin can be reviewed `here <https://github.com/TermySequence/termysequence/blob/master/src/dist/plugins/rotate.mjs>`_.
