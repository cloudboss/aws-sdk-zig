const aws = @import("aws");

const FargateProfileHealth = @import("fargate_profile_health.zig").FargateProfileHealth;
const FargateProfileSelector = @import("fargate_profile_selector.zig").FargateProfileSelector;
const FargateProfileStatus = @import("fargate_profile_status.zig").FargateProfileStatus;

/// An object representing an Fargate profile.
pub const FargateProfile = struct {
    /// The name of your cluster.
    cluster_name: ?[]const u8,

    /// The Unix epoch timestamp at object creation.
    created_at: ?i64,

    /// The full Amazon Resource Name (ARN) of the Fargate profile.
    fargate_profile_arn: ?[]const u8,

    /// The name of the Fargate profile.
    fargate_profile_name: ?[]const u8,

    /// The health status of the Fargate profile. If there are issues with your
    /// Fargate
    /// profile's health, they are listed here.
    health: ?FargateProfileHealth,

    /// The Amazon Resource Name (ARN) of the `Pod` execution role to use for any
    /// `Pod`
    /// that matches the selectors in the Fargate profile. For more information, see
    /// [
    /// `Pod` execution
    /// role](https://docs.aws.amazon.com/eks/latest/userguide/pod-execution-role.html) in the *Amazon EKS User Guide*.
    pod_execution_role_arn: ?[]const u8,

    /// The selectors to match for a `Pod` to use this Fargate profile.
    selectors: ?[]const FargateProfileSelector,

    /// The current status of the Fargate profile.
    status: ?FargateProfileStatus,

    /// The IDs of subnets to launch a `Pod` into.
    subnets: ?[]const []const u8,

    /// Metadata that assists with categorization and organization.
    /// Each tag consists of a key and an optional value. You define both. Tags
    /// don't
    /// propagate to any other cluster or Amazon Web Services resources.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
        .created_at = "createdAt",
        .fargate_profile_arn = "fargateProfileArn",
        .fargate_profile_name = "fargateProfileName",
        .health = "health",
        .pod_execution_role_arn = "podExecutionRoleArn",
        .selectors = "selectors",
        .status = "status",
        .subnets = "subnets",
        .tags = "tags",
    };
};
