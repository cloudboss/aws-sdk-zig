/// Contains information about the routed resource.
pub const RoutedResource = struct {
    /// The ARN of the routed resource. For more information, see [Amazon Resource
    /// Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *AWS General Reference*.
    arn: ?[]const u8 = null,

    /// The name of the routed resource.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
    };
};
