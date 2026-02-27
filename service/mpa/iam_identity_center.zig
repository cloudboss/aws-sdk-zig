/// IAM Identity Center credentials. For more information see, [IAM Identity
/// Center](http://aws.amazon.com/identity-center/) .
pub const IamIdentityCenter = struct {
    /// Amazon Resource Name (ARN) for the IAM Identity Center instance.
    instance_arn: []const u8,

    /// Amazon Web Services Region where the IAM Identity Center instance is
    /// located.
    region: []const u8,

    pub const json_field_names = .{
        .instance_arn = "InstanceArn",
        .region = "Region",
    };
};
