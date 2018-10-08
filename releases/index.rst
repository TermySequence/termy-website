.. Copyright © 2018 TermySequence LLC
.. SPDX-License-Identifier: CC-BY-SA-4.0

Installation
============

.. highlight:: none

Install both **termy-server** and **termy-qt** on workstation/laptop. Install only **termy-server** on headless servers/containers.

Fedora
------

Supported versions: 28 and up

Install from the official Fedora repositories::

  # dnf install termy-qt termy-server

Ubuntu
------

Supported versions: 18.04 and up. In the following instructions, substitute the appropriate Ubuntu version if not 18.04.

Enable the Open Build Service repository by creating the file :file:`/etc/apt/sources.list.d/termysequence.list` with these contents::

  deb http://download.opensuse.org/repositories/home:/sigalrm/xUbuntu_18.04 ./

Download and trust the repository key::

  # curl https://download.opensuse.org/repositories/home:/sigalrm/xUbuntu_18.04/Release.key >repo.key
  # apt-key add repo.key

Refresh the repository list::

  # apt-get update

Install with :program:`apt-get`::

  # apt-get install termy-qt termy-server

OpenSUSE
--------

Supported versions: Tumbleweed

Enable the Open Build Service repository::

  # zypper addrepo --refresh http://download.opensuse.org/repositories/home:/sigalrm/openSUSE_Tumbleweed/home:sigalrm.repo

Install with :program:`zypper`::

  # zypper install termy-qt termy-server

Arch
----

Add the following lines to :file:`/etc/pacman.conf`::

  [termysequence]
  Server = http://download.opensuse.org/repositories/home:/sigalrm/Arch/x86_64
  SigLevel = Optional TrustAll

Download and trust the repository key::

  # curl https://download.opensuse.org/repositories/home:/sigalrm/Arch/x86_64/home_sigalrm_Arch.key >repo.key
  # pacman-key --add repo.key

Refresh the repository list::

  # pacman -Sy

Install with :program:`pacman`::

  # pacman -S termy-qt termy-server

.. _source-releases:

Source Releases
===============

termysequence-server
--------------------

The server source distribution, containing :program:`termy-server`

  * `ChangeLog <https://github.com/TermySequence/termysequence/blob/master/CHANGELOG.md>`_
  * `termysequence-server-1.1.4.tar.xz <termysequence-server-1.1.4.tar.xz>`_
  * `termysequence-server-1.1.4.sig <termysequence-server-1.1.4.sig>`_
  * `termysequence-server-1.1.4.sha256 <termysequence-server-1.1.4.sha256>`_

termysequence-qt
----------------

The Qt client source distribution, containing :program:`qtermy`

  * `ChangeLog <https://github.com/TermySequence/termysequence/blob/master/CHANGELOG.md>`_
  * `termysequence-qt-1.1.4.tar.xz <termysequence-qt-1.1.4.tar.xz>`_
  * `termysequence-qt-1.1.4.sig <termysequence-qt-1.1.4.sig>`_
  * `termysequence-qt-1.1.4.sha256 <termysequence-qt-1.1.4.sha256>`_

termy-doc
---------

A built copy of the `documentation <../doc>`_ in HTML format. Untar this on your hard drive, then point :program:`qtermy`'s `DocumentationRoot <../doc/settings/global.html#Global/DocumentationRoot>`_ at it for instant page loads when clicking Help buttons and links.

  * `termy-doc-html-1.1.4.tar.xz <termy-doc-html-1.1.4.tar.xz>`_
  * `termy-doc-html-1.1.4.sig <termy-doc-html-1.1.4.sig>`_
  * `termy-doc-html-1.1.4.sha256 <termy-doc-html-1.1.4.sha256>`_
