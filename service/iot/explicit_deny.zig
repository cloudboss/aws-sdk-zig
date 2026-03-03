const Policy = @import("policy.zig").Policy;

/// Information that explicitly denies authorization.
pub const ExplicitDeny = struct {
    /// The policies that denied the authorization.
    policies: ?[]const Policy = null,

    pub const json_field_names = .{
        .policies = "policies",
    };
};
