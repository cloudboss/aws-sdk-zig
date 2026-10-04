const LaunchTemplateSource = @import("launch_template_source.zig").LaunchTemplateSource;
const InstanceLifecycleConfiguration = @import("instance_lifecycle_configuration.zig").InstanceLifecycleConfiguration;
const RootVolumeConfiguration = @import("root_volume_configuration.zig").RootVolumeConfiguration;
const VolumeConfiguration = @import("volume_configuration.zig").VolumeConfiguration;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

/// The configuration for Amazon EC2-based compute, including the launch
/// template source, networking, storage volumes, and instance lifecycle
/// settings.
pub const Ec2Configuration = struct {
    /// The source of the launch template configuration that defines how instances
    /// are launched.
    launch_template_source: LaunchTemplateSource,

    /// The lifecycle configuration for instances in the capacity provider.
    lifecycle_configuration: ?InstanceLifecycleConfiguration = null,

    /// The configuration for the instance root volume. Specify the amount of free
    /// space to guarantee and, optionally, the Amazon EBS performance and
    /// encryption settings. The device name and delete-on-termination behavior are
    /// not configurable.
    root_volume: ?RootVolumeConfiguration = null,

    /// The named persistent Amazon EBS volumes for the capacity provider. A
    /// capacity provider can define up to five volumes.
    volumes: ?[]const VolumeConfiguration = null,

    /// The VPC configuration for launching instances, including subnets and
    /// security groups.
    vpc_configuration: VpcConfiguration,

    pub const json_field_names = .{
        .launch_template_source = "launchTemplateSource",
        .lifecycle_configuration = "lifecycleConfiguration",
        .root_volume = "rootVolume",
        .volumes = "volumes",
        .vpc_configuration = "vpcConfiguration",
    };
};
