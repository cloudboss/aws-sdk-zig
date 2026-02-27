const AutoScalingConfigurationStatus = @import("auto_scaling_configuration_status.zig").AutoScalingConfigurationStatus;

/// Describes an App Runner automatic scaling configuration resource.
///
/// A higher `MinSize` increases the spread of your App Runner service over more
/// Availability Zones in the Amazon Web Services Region. The tradeoff is a
/// higher
/// minimal cost.
///
/// A lower `MaxSize` controls your cost. The tradeoff is lower responsiveness
/// during peak demand.
///
/// Multiple revisions of a configuration might have the same
/// `AutoScalingConfigurationName` and different
/// `AutoScalingConfigurationRevision` values.
pub const AutoScalingConfiguration = struct {
    /// The Amazon Resource Name (ARN) of this auto scaling configuration.
    auto_scaling_configuration_arn: ?[]const u8,

    /// The customer-provided auto scaling configuration name. It can be used in
    /// multiple revisions of a configuration.
    auto_scaling_configuration_name: ?[]const u8,

    /// The revision of this auto scaling configuration. It's unique among all the
    /// active configurations (`"Status": "ACTIVE"`) that share the same
    /// `AutoScalingConfigurationName`.
    auto_scaling_configuration_revision: ?i32,

    /// The time when the auto scaling configuration was created. It's in Unix time
    /// stamp format.
    created_at: ?i64,

    /// The time when the auto scaling configuration was deleted. It's in Unix time
    /// stamp format.
    deleted_at: ?i64,

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

    /// It's set to `true` for the configuration with the highest `Revision` among
    /// all configurations that share the same
    /// `AutoScalingConfigurationName`. It's set to `false` otherwise.
    latest: ?bool,

    /// The maximum number of concurrent requests that an instance processes. If the
    /// number of concurrent requests exceeds this limit, App Runner scales the
    /// service
    /// up.
    max_concurrency: ?i32,

    /// The maximum number of instances that a service scales up to. At most
    /// `MaxSize` instances actively serve traffic for your service.
    max_size: ?i32,

    /// The minimum number of instances that App Runner provisions for a service.
    /// The service always has at least `MinSize` provisioned instances. Some
    /// of them actively serve traffic. The rest of them (provisioned and inactive
    /// instances) are a cost-effective compute capacity reserve and are ready to be
    /// quickly activated. You pay for memory usage of all the provisioned
    /// instances. You pay for CPU usage of only the active subset.
    ///
    /// App Runner temporarily doubles the number of provisioned instances during
    /// deployments, to maintain the same capacity for both old and new code.
    min_size: ?i32,

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
        .deleted_at = "DeletedAt",
        .has_associated_service = "HasAssociatedService",
        .is_default = "IsDefault",
        .latest = "Latest",
        .max_concurrency = "MaxConcurrency",
        .max_size = "MaxSize",
        .min_size = "MinSize",
        .status = "Status",
    };
};
