/// The IAM resource that enables Amazon Web Services IoT FleetWise edge agent
/// software to send data to
/// Amazon Timestream.
///
/// For more information, see [IAM
/// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) in
/// the
/// *Identity and Access Management User Guide*.
pub const IamResources = struct {
    /// The Amazon Resource Name (ARN) of the IAM resource that allows Amazon Web
    /// Services IoT FleetWise to send data to
    /// Amazon Timestream. For example,
    /// `arn:aws:iam::123456789012:role/SERVICE-ROLE-ARN`.
    role_arn: []const u8,

    pub const json_field_names = .{
        .role_arn = "roleArn",
    };
};
