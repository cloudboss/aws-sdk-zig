/// Wrapper for updating an optional Description field with PATCH semantics.
/// When present in an update request, the description is replaced with
/// optionalValue. When absent, the description is left unchanged. To unset the
/// description, include the wrapper with optionalValue not specified.
pub const UpdatedDescription = struct {
    /// Represents an optional value that is used to update the human-readable
    /// description of the resource. If not specified, it will clear the current
    /// description of the resource.
    optional_value: ?[]const u8 = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
