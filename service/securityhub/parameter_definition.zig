const ConfigurationOptions = @import("configuration_options.zig").ConfigurationOptions;

/// An object that describes a security control parameter and the options for
/// customizing it.
pub const ParameterDefinition = struct {
    /// The options for customizing a control parameter. Customization options vary
    /// based on the data type of the parameter.
    configuration_options: ConfigurationOptions,

    /// Description of a control parameter.
    description: []const u8,

    pub const json_field_names = .{
        .configuration_options = "ConfigurationOptions",
        .description = "Description",
    };
};
