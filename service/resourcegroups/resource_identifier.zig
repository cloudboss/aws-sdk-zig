/// A structure that contains the ARN of a resource and its resource type.
pub const ResourceIdentifier = struct {
    /// The Amazon resource name (ARN) of a resource.
    resource_arn: ?[]const u8,

    /// The resource type of a resource, such as `AWS::EC2::Instance`.
    resource_type: ?[]const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_type = "ResourceType",
    };
};
