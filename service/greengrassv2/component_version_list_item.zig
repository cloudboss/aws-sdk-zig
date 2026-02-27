/// Contains information about a component version in a list.
pub const ComponentVersionListItem = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the component version.
    arn: ?[]const u8,

    /// The name of the component.
    component_name: ?[]const u8,

    /// The version of the component.
    component_version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .component_name = "componentName",
        .component_version = "componentVersion",
    };
};
