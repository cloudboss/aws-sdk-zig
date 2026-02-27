const InstanceBlockDeviceMapping = @import("instance_block_device_mapping.zig").InstanceBlockDeviceMapping;

/// Defines a custom base AMI and block device mapping configurations of an
/// instance used
/// for building and testing container images.
pub const InstanceConfiguration = struct {
    /// Defines the block devices to attach for building an instance from this Image
    /// Builder
    /// AMI.
    block_device_mappings: ?[]const InstanceBlockDeviceMapping,

    /// The base image for a container build and test instance. This can contain an
    /// AMI ID
    /// or it can specify an Amazon Web Services Systems Manager (SSM) Parameter
    /// Store Parameter, prefixed by `ssm:`,
    /// followed by the parameter name or ARN.
    ///
    /// If not specified, Image Builder uses the appropriate ECS-optimized AMI as a
    /// base image.
    image: ?[]const u8,

    pub const json_field_names = .{
        .block_device_mappings = "blockDeviceMappings",
        .image = "image",
    };
};
