# Planning and Reasoning Project

~~~bash
docker run  -v./pddl:/computer -it --privileged --rm docker.io/library/myplauntils bash
planutils activate
enhsp -o domain.pddl -f <instance> -s astar -h <heuristic> [hadd|hmax]
~~~

## Indigolog section

~~~bash
swipl <configs>.pl indigolog/main.pl
~~~
