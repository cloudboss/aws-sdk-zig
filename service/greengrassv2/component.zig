const ComponentLatestVersion = @import("component_latest_version.zig").ComponentLatestVersion;

/// Contains information about a component.
pub const Component = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the component version.
    arn: ?[]const u8 = null,

    /// The name of the component.
    component_name: ?[]const u8 = null,

    /// The latest version of the component and its details.
    latest_version: ?ComponentLatestVersion = null,

    pub const json_field_names = .{
        .arn = "arn",
        .component_name = "componentName",
        .latest_version = "latestVersion",
    };
};
