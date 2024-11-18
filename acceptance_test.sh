 #!/bin/bash
 test $(curl localhost:8769/sum?a=2\&b=2) -eq 4
