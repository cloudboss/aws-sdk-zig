const ComponentParameter = @import("component_parameter.zig").ComponentParameter;

/// Configuration details of the component. You can specify each component only
/// once in a recipe, regardless of version. Components with a status of
/// `DEPRECATED` or `DISABLED` can't be added to new
/// recipes.
pub const ComponentConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the component. You can specify a build
    /// version ARN, or a
    /// component version ARN whose version segments can use `x`
    /// wildcards, for example `1.x.x`.
    component_arn: []const u8,

    /// A group of parameter settings that Image Builder uses to configure the
    /// component for
    /// a specific recipe. You must supply a value for every component parameter
    /// that has no default value, and you can only supply parameters that the
    /// component defines.
    parameters: ?[]const ComponentParameter = null,

    pub const json_field_names = .{
        .component_arn = "componentArn",
        .parameters = "parameters",
    };
};
