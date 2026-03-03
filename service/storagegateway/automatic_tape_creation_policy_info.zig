const AutomaticTapeCreationRule = @import("automatic_tape_creation_rule.zig").AutomaticTapeCreationRule;

/// Information about the gateway's automatic tape creation policies, including
/// the
/// automatic tape creation rules and the gateway that is using the policies.
pub const AutomaticTapeCreationPolicyInfo = struct {
    /// An automatic tape creation policy consists of a list of automatic tape
    /// creation rules.
    /// This returns the rules that determine when and how to automatically create
    /// new
    /// tapes.
    automatic_tape_creation_rules: ?[]const AutomaticTapeCreationRule = null,

    gateway_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .automatic_tape_creation_rules = "AutomaticTapeCreationRules",
        .gateway_arn = "GatewayARN",
    };
};
