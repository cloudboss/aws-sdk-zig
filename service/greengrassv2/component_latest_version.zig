const ComponentPlatform = @import("component_platform.zig").ComponentPlatform;

/// Contains information about the latest version of a component.
pub const ComponentLatestVersion = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the component version.
    arn: ?[]const u8 = null,

    /// The version of the component.
    component_version: ?[]const u8 = null,

    /// The time at which the component was created, expressed in ISO 8601 format.
    creation_timestamp: ?i64 = null,

    /// The description of the component version.
    description: ?[]const u8 = null,

    /// The platforms that the component version supports.
    platforms: ?[]const ComponentPlatform = null,

    /// The publisher of the component version.
    publisher: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .component_version = "componentVersion",
        .creation_timestamp = "creationTimestamp",
        .description = "description",
        .platforms = "platforms",
        .publisher = "publisher",
    };
};
