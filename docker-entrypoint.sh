#!/bin/bash
set -e

/usr/local/bin/gomplate -f /ssmtp.conf.tmpl -o /etc/ssmtp/ssmtp.conf

apache2-foreground
