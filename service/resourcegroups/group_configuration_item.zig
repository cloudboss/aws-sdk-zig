const GroupConfigurationParameter = @import("group_configuration_parameter.zig").GroupConfigurationParameter;

/// An item in a group configuration. A group service configuration can have one
/// or more
/// items. For details about group service configuration syntax, see [Service
/// configurations for
/// resource
/// groups](https://docs.aws.amazon.com/ARG/latest/APIReference/about-slg.html).
pub const GroupConfigurationItem = struct {
    /// A collection of parameters for this group configuration item. For the list
    /// of
    /// parameters that you can use with each configuration item type, see
    /// [Supported
    /// resource types and
    /// parameters](https://docs.aws.amazon.com/ARG/latest/APIReference/about-slg.html#about-slg-types).
    parameters: ?[]const GroupConfigurationParameter,

    /// Specifies the type of group configuration item. Each item must have a unique
    /// value for
    /// `type`. For the list of types that you can specify for a configuration
    /// item, see [Supported resource types and
    /// parameters](https://docs.aws.amazon.com/ARG/latest/APIReference/about-slg.html#about-slg-types).
    @"type": []const u8,

    pub const json_field_names = .{
        .parameters = "Parameters",
        .@"type" = "Type",
    };
};
