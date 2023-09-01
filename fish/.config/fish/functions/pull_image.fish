function pull_image --argument image
ssh -t sepia-server docker exec -it $image git pull
end
