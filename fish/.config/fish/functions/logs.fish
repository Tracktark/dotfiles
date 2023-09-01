function logs --argument container
ssh -t sepia-server docker logs -f -n 30 $container
end
