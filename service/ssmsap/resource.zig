/// The resource contains a `ResourceArn` and the `ResourceType`.
pub const Resource = struct {
    /// The Amazon Resource Name (ARN) of the source resource.
    ///
    /// Example of `ResourceArn`:
    /// "`arn:aws:ec2:us-east-1:111111111111:instance/i-abcdefgh987654321`"
    resource_arn: ?[]const u8,

    /// The resource type.
    ///
    /// Example of `ResourceType`: "`AWS::SystemsManagerSAP::Component`" or
    /// "`AWS::EC2::Instance`".
    resource_type: ?[]const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_type = "ResourceType",
    };
};
