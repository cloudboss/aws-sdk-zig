const ToolsDefinition = @import("tools_definition.zig").ToolsDefinition;

/// Wrapper for updating a tools definition with PATCH semantics. When present,
/// the tools definition is replaced with the provided value. When absent, the
/// tools definition is left unchanged. To unset, include the wrapper with the
/// value set to null.
pub const UpdatedToolsDefinition = struct {
    /// The updated tools definition value.
    optional_value: ?ToolsDefinition = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
