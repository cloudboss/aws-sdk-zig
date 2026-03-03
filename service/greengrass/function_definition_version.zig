const FunctionDefaultConfig = @import("function_default_config.zig").FunctionDefaultConfig;
const Function = @import("function.zig").Function;

/// Information about a function definition version.
pub const FunctionDefinitionVersion = struct {
    /// The default configuration that applies to all Lambda functions in this
    /// function definition version. Individual Lambda functions can override these
    /// settings.
    default_config: ?FunctionDefaultConfig = null,

    /// A list of Lambda functions in this function definition version.
    functions: ?[]const Function = null,

    pub const json_field_names = .{
        .default_config = "DefaultConfig",
        .functions = "Functions",
    };
};
