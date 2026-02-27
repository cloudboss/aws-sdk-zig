/// A parameter for a group configuration item. For details about group service
/// configuration syntax, see [Service configurations for resource
/// groups](https://docs.aws.amazon.com/ARG/latest/APIReference/about-slg.html).
pub const GroupConfigurationParameter = struct {
    /// The name of the group configuration parameter. For the list of parameters
    /// that you can
    /// use with each configuration item type, see [Supported resource types and
    /// parameters](https://docs.aws.amazon.com/ARG/latest/APIReference/about-slg.html#about-slg-types).
    name: []const u8,

    /// The value or values to be used for the specified parameter. For the list of
    /// values you
    /// can use with each parameter, see [Supported resource types and
    /// parameters](https://docs.aws.amazon.com/ARG/latest/APIReference/about-slg.html#about-slg-types).
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
