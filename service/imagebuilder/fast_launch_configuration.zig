const FastLaunchLaunchTemplateSpecification = @import("fast_launch_launch_template_specification.zig").FastLaunchLaunchTemplateSpecification;
const FastLaunchSnapshotConfiguration = @import("fast_launch_snapshot_configuration.zig").FastLaunchSnapshotConfiguration;

/// Defines and configures EC2 Fast Launch for output Windows AMIs.
pub const FastLaunchConfiguration = struct {
    /// The owner account ID for the fast-launch enabled Windows AMI.
    account_id: ?[]const u8 = null,

    /// Specifies whether to enable Windows fast launch on the output AMI during
    /// distribution. A value of `false` means Image Builder takes no
    /// fast-launch action for this configuration.
    enabled: bool = false,

    /// The launch template that the fast-launch enabled Windows AMI uses when it
    /// launches
    /// Windows instances to create pre-provisioned snapshots.
    launch_template: ?FastLaunchLaunchTemplateSpecification = null,

    /// The maximum number of parallel instances that are launched for creating
    /// resources.
    max_parallel_launches: ?i32 = null,

    /// Configuration settings for managing the number of snapshots that are created
    /// from
    /// pre-provisioned instances for the Windows AMI when Windows fast launch is
    /// enabled.
    snapshot_configuration: ?FastLaunchSnapshotConfiguration = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .enabled = "enabled",
        .launch_template = "launchTemplate",
        .max_parallel_launches = "maxParallelLaunches",
        .snapshot_configuration = "snapshotConfiguration",
    };
};
