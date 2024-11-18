#!/bin/bash
 test $(curl localhost:8888/sum?a=2\&b=2) -eq 4
