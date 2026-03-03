/// Contains details about the EC2 AMI that was scanned.
pub const Ec2ImageDetails = struct {
    /// The Amazon Resource Name (ARN) of the EC2 AMI.
    image_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_arn = "ImageArn",
    };
};
