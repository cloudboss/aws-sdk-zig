const ManagementType = @import("management_type.zig").ManagementType;

/// Contains information about Amazon Web Services Fargate details associated
/// with
/// an Amazon ECS cluster.
pub const FargateDetails = struct {
    /// Runtime coverage issues identified for the resource running on Amazon Web
    /// Services Fargate.
    issues: ?[]const []const u8,

    /// Indicates how the GuardDuty security agent is managed for this resource.
    ///
    /// * `AUTO_MANAGED` indicates that GuardDuty deploys and manages updates for
    ///   this resource.
    ///
    /// * `DISABLED` indicates that the deployment of the GuardDuty security agent
    ///   is disabled for this resource.
    ///
    /// The `MANUAL` status doesn't apply to the Amazon Web Services Fargate (Amazon
    /// ECS only) woprkloads.
    management_type: ?ManagementType,

    pub const json_field_names = .{
        .issues = "Issues",
        .management_type = "ManagementType",
    };
};
