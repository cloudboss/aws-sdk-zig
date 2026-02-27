const CisRuleStatus = @import("cis_rule_status.zig").CisRuleStatus;

/// The CIS session message.
pub const CisSessionMessage = struct {
    /// The CIS rule details for the CIS session message.
    cis_rule_details: []const u8,

    /// The rule ID for the CIS session message.
    rule_id: []const u8,

    /// The status of the CIS session message.
    status: CisRuleStatus,

    pub const json_field_names = .{
        .cis_rule_details = "cisRuleDetails",
        .rule_id = "ruleId",
        .status = "status",
    };
};
