const IamInstanceProfile = @import("iam_instance_profile.zig").IamInstanceProfile;
const ProductCode = @import("product_code.zig").ProductCode;

/// Details about the potentially impacted Amazon EC2 instance resource.
pub const Ec2Instance = struct {
    /// The availability zone of the Amazon EC2 instance. For more information, see
    /// [Availability
    /// zones](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-availability-zones)
    /// in the *Amazon EC2 User Guide*.
    availability_zone: ?[]const u8 = null,

    /// The ID of the network interface.
    ec_2_network_interface_uids: ?[]const []const u8 = null,

    iam_instance_profile: ?IamInstanceProfile = null,

    /// The image description of the Amazon EC2 instance.
    image_description: ?[]const u8 = null,

    /// The state of the Amazon EC2 instance. For more information, see
    /// [Amazon EC2 instance state
    /// changes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-lifecycle.html)
    /// in the *Amazon EC2 User Guide*.
    instance_state: ?[]const u8 = null,

    /// Type of the Amazon EC2 instance.
    instance_type: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Outpost. This
    /// shows applicable Amazon Web Services Outposts instances.
    outpost_arn: ?[]const u8 = null,

    /// The platform of the Amazon EC2 instance.
    platform: ?[]const u8 = null,

    /// The product code of the Amazon EC2 instance.
    product_codes: ?[]const ProductCode = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .ec_2_network_interface_uids = "Ec2NetworkInterfaceUids",
        .iam_instance_profile = "IamInstanceProfile",
        .image_description = "ImageDescription",
        .instance_state = "InstanceState",
        .instance_type = "InstanceType",
        .outpost_arn = "OutpostArn",
        .platform = "Platform",
        .product_codes = "ProductCodes",
    };
};
