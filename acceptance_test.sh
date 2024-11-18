#!/bin/bash
 test $(curl localhost:8881/sum?a=2\&b=2) -eq 4
