#!/bin/bash

# Prompt the user for their Docker Hub username
echo -n "Enter your Docker Hub username: "
read USERNAME

# Login to Docker Hub
docker login -u "${USERNAME}"

# Assuming the repository name is static; otherwise, you could prompt for it as well
REPOSITORY="pm2"

# Change to the directory containing your version directories. Ensure to replace with the actual path
cd ./tags || exit

# Loop over version directories (e.g., 16, 18, 20, 22, latest)
for version in */ ; do
    version=${version%/}  # Remove the trailing slash

    # Loop over variant directories within each version (e.g., alpine, bookworm, slim)
    for variant in "$version"/* ; do
        variant_name=${variant#*/}  # Extract the variant name

        if [ "$version" = "latest" ] && [ "$variant_name" = "alpine" ]; then
            # For latest/alpine, tag as latest-alpine, alpine, and latest
            DOCKER_TAG_LATEST_ALPINE="${USERNAME}/${REPOSITORY}:latest-alpine"
            DOCKER_TAG_ALPINE="${USERNAME}/${REPOSITORY}:alpine"
            DOCKER_TAG_LATEST="${USERNAME}/${REPOSITORY}:latest"
            docker build -t "$DOCKER_TAG_LATEST_ALPINE" -t "$DOCKER_TAG_ALPINE" -t "$DOCKER_TAG_LATEST" "./$variant"
            echo "Pushing $DOCKER_TAG_LATEST_ALPINE, $DOCKER_TAG_ALPINE and $DOCKER_TAG_LATEST to Docker Hub..."
            docker push "$DOCKER_TAG_LATEST_ALPINE"
            docker push "$DOCKER_TAG_ALPINE"
            docker push "$DOCKER_TAG_LATEST"
        elif [ "$variant_name" = "alpine" ]; then
            # For version/alpine, tag as both version-alpine and version
            DOCKER_TAG_VERSION_ALPINE="${USERNAME}/${REPOSITORY}:${version}-${variant_name}"
            DOCKER_TAG_VERSION="${USERNAME}/${REPOSITORY}:${version}"
            docker build -t "$DOCKER_TAG_VERSION_ALPINE" -t "$DOCKER_TAG_VERSION" "./$variant"
            echo "Pushing $DOCKER_TAG_VERSION_ALPINE and $DOCKER_TAG_VERSION to Docker Hub..."
            docker push "$DOCKER_TAG_VERSION_ALPINE"
            docker push "$DOCKER_TAG_VERSION"
        else
            # For other variants, just use the version-variant format
            DOCKER_TAG="${USERNAME}/${REPOSITORY}:${version}-${variant_name}"
            docker build -t "$DOCKER_TAG" "./$variant"
            echo "Pushing $DOCKER_TAG to Docker Hub..."
            docker push "$DOCKER_TAG"
        fi
    done
done

echo "All Docker images have been built and pushed successfully."