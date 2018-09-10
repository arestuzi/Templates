#!/bin/bash
TARGET=/proc/sysrq-trigger

for i in {1..10}
do
  echo t > $TARGET
  sleep(1)
  echo m > $TARGET
  sleep(1)
done
