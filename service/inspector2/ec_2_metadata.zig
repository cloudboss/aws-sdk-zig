const aws = @import("aws");

const Ec2Platform = @import("ec_2_platform.zig").Ec2Platform;

/// Meta data details of an Amazon EC2 instance.
pub const Ec2Metadata = struct {
    /// The ID of the Amazon Machine Image (AMI) used to launch the instance.
    ami_id: ?[]const u8,

    /// The platform of the instance.
    platform: ?Ec2Platform,

    /// The tags attached to the instance.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .ami_id = "amiId",
        .platform = "platform",
        .tags = "tags",
    };
};
