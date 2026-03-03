const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// A collection of settings that configure the domain's Docker interaction.
pub const DockerSettings = struct {
    /// Indicates whether the domain can access Docker.
    enable_docker_access: ?FeatureStatus = null,

    /// Indicates whether to use rootless Docker.
    rootless_docker: ?FeatureStatus = null,

    /// The list of Amazon Web Services accounts that are trusted when the domain is
    /// created in VPC-only mode.
    vpc_only_trusted_accounts: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .enable_docker_access = "EnableDockerAccess",
        .rootless_docker = "RootlessDocker",
        .vpc_only_trusted_accounts = "VpcOnlyTrustedAccounts",
    };
};
