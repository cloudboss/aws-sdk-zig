const EffectiveLimit = @import("effective_limit.zig").EffectiveLimit;

/// The effective limits for an Amazon Quick Sight user.
pub const UserLimits = struct {
    /// A list of effective limits for the user.
    effective_limits: []const EffectiveLimit,

    /// The namespace of the user.
    namespace: []const u8,

    /// The name of the user.
    user_name: []const u8,

    pub const json_field_names = .{
        .effective_limits = "effectiveLimits",
        .namespace = "namespace",
        .user_name = "userName",
    };
};
