event-handler test
   trigger on-startup-config
   action bash
      #!/usr/bin/python
      import os
      with open( '/tmp/test', 'w' ) as f:
         f.write( 'This is a test' )
      EOF
event-handler test2
   action bash
      rm /mnt/flash/veos-config
      touch /mnt/flash/veos-config
      chmod 755 /mnt/flash/veos-config
      printf "%s\n" $'SERIALNUMBER='$HOSTNAME >> /mnt/flash/veos-config
      printf "%s\n" $'SYSTEMMACADDR=001c.73'$((RANDOM % 99))'.'$((RANDOM % 9999)) >> /mnt/flash/veos-config
      FastCli -c 'write memory' -p 15
      FastCli -c 'reload now' -p 15
      EOF
   threshold 10 count 1
   !
   trigger on-counters
      poll interval 8
      condition bashCmd."if test -f /mnt/flash/veos-config; then tracker=1; else tracker=0; fi; echo $tracker" < 1



rm /mnt/flash/veos-config
touch /mnt/flash/veos-config
chmod 755 /mnt/flash/veos-config
printf "%s\n" $'SERIALNUMBER='$HOSTNAME >> /mnt/flash/veos-config
printf "%s\n" $'SYSTEMMACADDR=001c.73'$((RANDOM % 99))'.'$((RANDOM % 9999)) >> /mnt/flash/veos-config
EOF

