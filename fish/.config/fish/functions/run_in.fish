function run_in --argument container
ssh -t sepia-server docker exec -it $container $argv[2..]
end
