/// A reference to a scope in a create or update request.
pub const ScopeReference = struct {
    /// The identifier of the scope. This is the scope's Amazon Resource Name (ARN).
    scope_identifier: []const u8,

    pub const json_field_names = .{
        .scope_identifier = "scopeIdentifier",
    };
};
