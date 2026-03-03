/// A JSON-formatted object that contains the IDs for an Amazon Machine Image
/// (AMI),
/// including the Amazon EC2-compatible AMI ID and the Snow device AMI ID. Each
/// AMI has these two IDs to
/// simplify identifying the AMI in both the Amazon Web Services Cloud and on
/// the device.
pub const Ec2AmiResource = struct {
    /// The ID of the AMI in Amazon EC2.
    ami_id: []const u8,

    /// The ID of the AMI on the Snow device.
    snowball_ami_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ami_id = "AmiId",
        .snowball_ami_id = "SnowballAmiId",
    };
};
