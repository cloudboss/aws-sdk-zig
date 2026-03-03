/// IAM Identity Center credentials. For more information see, [IAM Identity
/// Center](http://aws.amazon.com/identity-center/) .
pub const IamIdentityCenterForGet = struct {
    /// URL for the approval portal associated with the IAM Identity Center
    /// instance.
    approval_portal_url: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) for the IAM Identity Center instance.
    instance_arn: ?[]const u8 = null,

    /// Amazon Web Services Region where the IAM Identity Center instance is
    /// located.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .approval_portal_url = "ApprovalPortalUrl",
        .instance_arn = "InstanceArn",
        .region = "Region",
    };
};
