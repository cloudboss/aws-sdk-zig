/// An association between a deployment and a scope, as returned in outputs. The
/// corresponding request structure is `ScopeReference`.
pub const AssociatedScope = struct {
    /// The ARN of the associated scope.
    scope_arn: []const u8,

    pub const json_field_names = .{
        .scope_arn = "scopeArn",
    };
};
