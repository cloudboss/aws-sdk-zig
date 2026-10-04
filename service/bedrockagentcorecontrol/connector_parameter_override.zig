/// Specifies a parameter override for a connector tool, allowing you to control
/// parameter visibility and descriptions.
pub const ConnectorParameterOverride = struct {
    /// An agent-facing description override for this parameter.
    description: ?[]const u8 = null,

    /// A JSON Pointer path identifying the parameter (for example,
    /// `/numberOfResults` or `/filter`).
    path: []const u8,

    /// Whether this parameter is visible to the agent. If not specified, uses the
    /// service default.
    visible: ?bool = null,

    pub const json_field_names = .{
        .description = "description",
        .path = "path",
        .visible = "visible",
    };
};
