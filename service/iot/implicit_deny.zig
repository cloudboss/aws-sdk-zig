const Policy = @import("policy.zig").Policy;

/// Information that implicitly denies authorization. When policy doesn't
/// explicitly deny
/// or allow an action on a resource it is considered an implicit deny.
pub const ImplicitDeny = struct {
    /// Policies that don't contain a matching allow or deny statement for the
    /// specified
    /// action on the specified resource.
    policies: ?[]const Policy,

    pub const json_field_names = .{
        .policies = "policies",
    };
};
