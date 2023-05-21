Maintenance
===========

Scripts to maintain my machines via GitHub Actions runs.
Nothing to see here really.

Usage
-----

This is an Ansible playbook; it's very non-generic and heavily customized to
how my machines are set up.
The primary usage scenario is going to this repository's Actions and running
the workflow.

You can also run it manually; first, install the Ansible Galaxy dependencies:

    make deps

Make sure you can SSH to the hosts as the `maintenance` user; then, you can run
the playbook:

    make run

Reboot everything:

    make reboot

Reboot my cloud servers only:

    make reboot/cloud
