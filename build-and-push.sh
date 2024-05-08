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

        if [ "$version" = "latest" ]; then
            # For latest/variant, tag as variant
            DOCKER_TAG_VARIANT="${USERNAME}/${REPOSITORY}:${variant_name}"
            docker build -t "$DOCKER_TAG_VARIANT" "./$variant"
            echo "Pushing $DOCKER_TAG_VARIANT to Docker Hub..."
            docker push "$DOCKER_TAG_VARIANT"
        fi

        if [ "$variant_name" = "alpine" ]; then
            # For version/alpine, tag as version
            DOCKER_TAG_VERSON="${USERNAME}/${REPOSITORY}:${version}"
            docker build -t "$DOCKER_TAG_VERSON" "./$variant"
            echo "Pushing $DOCKER_TAG_VERSON to Docker Hub..."
            docker push "$DOCKER_TAG_VERSON"
        fi

        # For other variants, just use the version-variant format
        DOCKER_TAG="${USERNAME}/${REPOSITORY}:${version}-${variant_name}"
        docker build -t "$DOCKER_TAG" "./$variant"
        echo "Pushing $DOCKER_TAG to Docker Hub..."
        docker push "$DOCKER_TAG"
    done
done

echo "All Docker images have been built and pushed successfully."