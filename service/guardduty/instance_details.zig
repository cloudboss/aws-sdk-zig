const IamInstanceProfile = @import("iam_instance_profile.zig").IamInstanceProfile;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const ProductCode = @import("product_code.zig").ProductCode;
const Tag = @import("tag.zig").Tag;

/// Contains information about the details of an instance.
pub const InstanceDetails = struct {
    /// The Availability Zone of the EC2 instance.
    availability_zone: ?[]const u8 = null,

    /// The profile information of the EC2 instance.
    iam_instance_profile: ?IamInstanceProfile = null,

    /// The image description of the EC2 instance.
    image_description: ?[]const u8 = null,

    /// The image ID of the EC2 instance.
    image_id: ?[]const u8 = null,

    /// The ID of the EC2 instance.
    instance_id: ?[]const u8 = null,

    /// The state of the EC2 instance.
    instance_state: ?[]const u8 = null,

    /// The type of the EC2 instance.
    instance_type: ?[]const u8 = null,

    /// The launch time of the EC2 instance.
    launch_time: ?[]const u8 = null,

    /// The elastic network interface information of the EC2 instance.
    network_interfaces: ?[]const NetworkInterface = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Outpost. Only
    /// applicable to Amazon Web Services Outposts instances.
    outpost_arn: ?[]const u8 = null,

    /// The platform of the EC2 instance.
    platform: ?[]const u8 = null,

    /// The product code of the EC2 instance.
    product_codes: ?[]const ProductCode = null,

    /// The tags of the EC2 instance.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .iam_instance_profile = "IamInstanceProfile",
        .image_description = "ImageDescription",
        .image_id = "ImageId",
        .instance_id = "InstanceId",
        .instance_state = "InstanceState",
        .instance_type = "InstanceType",
        .launch_time = "LaunchTime",
        .network_interfaces = "NetworkInterfaces",
        .outpost_arn = "OutpostArn",
        .platform = "Platform",
        .product_codes = "ProductCodes",
        .tags = "Tags",
    };
};
