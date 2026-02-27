const BlockAction = @import("block_action.zig").BlockAction;
const CountAction = @import("count_action.zig").CountAction;

/// Specifies the action setting that Shield Advanced should use in the WAF
/// rules that it creates on behalf of the
/// protected resource in response to DDoS attacks. You specify this as part of
/// the configuration for the automatic application layer DDoS mitigation
/// feature,
/// when you enable or update automatic mitigation. Shield Advanced creates the
/// WAF rules in a Shield Advanced-managed rule group, inside the web ACL that
/// you have associated with the resource.
pub const ResponseAction = struct {
    /// Specifies that Shield Advanced should configure its WAF rules with the WAF
    /// `Block` action.
    ///
    /// You must specify exactly one action, either `Block` or `Count`.
    block: ?BlockAction,

    /// Specifies that Shield Advanced should configure its WAF rules with the WAF
    /// `Count` action.
    ///
    /// You must specify exactly one action, either `Block` or `Count`.
    count: ?CountAction,

    pub const json_field_names = .{
        .block = "Block",
        .count = "Count",
    };
};
