const InputConfiguration = @import("input_configuration.zig").InputConfiguration;
const InputDefinition = @import("input_definition.zig").InputDefinition;

/// Information about the input.
pub const Input = struct {
    /// Information about the configuration of an input.
    input_configuration: ?InputConfiguration = null,

    /// The definition of the input.
    input_definition: ?InputDefinition = null,

    pub const json_field_names = .{
        .input_configuration = "inputConfiguration",
        .input_definition = "inputDefinition",
    };
};
