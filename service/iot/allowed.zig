const Policy = @import("policy.zig").Policy;

/// Contains information that allowed the authorization.
pub const Allowed = struct {
    /// A list of policies that allowed the authentication.
    policies: ?[]const Policy = null,

    pub const json_field_names = .{
        .policies = "policies",
    };
};
