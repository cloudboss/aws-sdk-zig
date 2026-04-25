const std = @import("std");

pub const UpstreamRegistry = enum {
    ecr,
    ecr_public,
    quay,
    k8_s,
    docker_hub,
    git_hub_container_registry,
    azure_container_registry,
    git_lab_container_registry,
    chainguard,

    pub const json_field_names = .{
        .ecr = "ecr",
        .ecr_public = "ecr-public",
        .quay = "quay",
        .k8_s = "k8s",
        .docker_hub = "docker-hub",
        .git_hub_container_registry = "github-container-registry",
        .azure_container_registry = "azure-container-registry",
        .git_lab_container_registry = "gitlab-container-registry",
        .chainguard = "chainguard",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ecr => "ecr",
            .ecr_public => "ecr-public",
            .quay => "quay",
            .k8_s => "k8s",
            .docker_hub => "docker-hub",
            .git_hub_container_registry => "github-container-registry",
            .azure_container_registry => "azure-container-registry",
            .git_lab_container_registry => "gitlab-container-registry",
            .chainguard => "chainguard",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
