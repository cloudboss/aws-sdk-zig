const FunctionDefinition = @import("function_definition.zig").FunctionDefinition;

/// Contains details about the function schema for the action group or the JSON
/// or YAML-formatted payload defining the schema.
pub const FunctionSchema = union(enum) {
    /// A list of functions that each define an action in the action group.
    functions: ?[]const FunctionDefinition,

    pub const json_field_names = .{
        .functions = "functions",
    };
};
