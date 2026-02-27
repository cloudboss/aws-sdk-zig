const Action = @import("action.zig").Action;

/// Condition that matches based on the specific WAF action taken on the
/// request.
pub const ActionCondition = struct {
    /// The WAF action to match against (ALLOW, BLOCK, COUNT, CAPTCHA, CHALLENGE,
    /// EXCLUDED_AS_COUNT).
    action: ?Action,

    pub const json_field_names = .{
        .action = "Action",
    };
};
