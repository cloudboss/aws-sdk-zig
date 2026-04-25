const ServerDefinition = @import("server_definition.zig").ServerDefinition;

/// Wrapper for updating a server definition with PATCH semantics. When present,
/// the server definition is replaced with the provided value. When absent, the
/// server definition is left unchanged. To unset, include the wrapper with the
/// value set to null.
pub const UpdatedServerDefinition = struct {
    /// The updated server definition value.
    optional_value: ?ServerDefinition = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
