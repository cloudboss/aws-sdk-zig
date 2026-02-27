pub const UpstreamRegistry = enum {
    ecr,
    ecr_public,
    quay,
    k8_s,
    docker_hub,
    git_hub_container_registry,
    azure_container_registry,
    git_lab_container_registry,

    pub const json_field_names = .{
        .ecr = "Ecr",
        .ecr_public = "EcrPublic",
        .quay = "Quay",
        .k8_s = "K8s",
        .docker_hub = "DockerHub",
        .git_hub_container_registry = "GitHubContainerRegistry",
        .azure_container_registry = "AzureContainerRegistry",
        .git_lab_container_registry = "GitLabContainerRegistry",
    };
};
