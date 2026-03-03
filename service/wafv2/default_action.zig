const AllowAction = @import("allow_action.zig").AllowAction;
const BlockAction = @import("block_action.zig").BlockAction;

/// In a WebACL, this is the action that you want WAF to perform
/// when a web request doesn't match any of the rules in the `WebACL`. The
/// default
/// action must be a terminating action.
pub const DefaultAction = struct {
    /// Specifies that WAF should allow requests by default.
    allow: ?AllowAction = null,

    /// Specifies that WAF should block requests by default.
    block: ?BlockAction = null,

    pub const json_field_names = .{
        .allow = "Allow",
        .block = "Block",
    };
};
