const AutoScalingConfigurationStatus = @import("auto_scaling_configuration_status.zig").AutoScalingConfigurationStatus;

/// Provides summary information about an App Runner automatic scaling
/// configuration resource.
///
/// This type contains limited information about an auto scaling configuration.
/// It includes only identification information, without configuration
/// details. It's returned by the ListAutoScalingConfigurations action. Complete
/// configuration information is returned by the CreateAutoScalingConfiguration,
/// DescribeAutoScalingConfiguration, and DeleteAutoScalingConfiguration
/// actions using the AutoScalingConfiguration type.
pub const AutoScalingConfigurationSummary = struct {
    /// The Amazon Resource Name (ARN) of this auto scaling configuration.
    auto_scaling_configuration_arn: ?[]const u8,

    /// The customer-provided auto scaling configuration name. It can be used in
    /// multiple revisions of a configuration.
    auto_scaling_configuration_name: ?[]const u8,

    /// The revision of this auto scaling configuration. It's unique among all the
    /// active configurations (`"Status": "ACTIVE"`) with the same
    /// `AutoScalingConfigurationName`.
    auto_scaling_configuration_revision: i32 = 0,

    /// The time when the auto scaling configuration was created. It's in Unix time
    /// stamp format.
    created_at: ?i64,

    /// Indicates if this auto scaling configuration has an App Runner service
    /// associated with it. A value of `true` indicates one or more services are
    /// associated. A value of `false` indicates no services are associated.
    has_associated_service: ?bool,

    /// Indicates if this auto scaling configuration should be used as the default
    /// for a new App Runner service that does not have an
    /// auto scaling configuration ARN specified during creation. Each account can
    /// have only one
    /// default `AutoScalingConfiguration` per region. The default
    /// `AutoScalingConfiguration` can be any revision under
    /// the same `AutoScalingConfigurationName`.
    is_default: ?bool,

    /// The current state of the auto scaling configuration. If the status of a
    /// configuration revision is `INACTIVE`, it was deleted and can't be
    /// used. Inactive configuration revisions are permanently removed some time
    /// after they are deleted.
    status: ?AutoScalingConfigurationStatus,

    pub const json_field_names = .{
        .auto_scaling_configuration_arn = "AutoScalingConfigurationArn",
        .auto_scaling_configuration_name = "AutoScalingConfigurationName",
        .auto_scaling_configuration_revision = "AutoScalingConfigurationRevision",
        .created_at = "CreatedAt",
        .has_associated_service = "HasAssociatedService",
        .is_default = "IsDefault",
        .status = "Status",
    };
};
