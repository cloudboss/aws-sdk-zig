/// The rule that a simulated user matches.
pub const MobileDeviceAccessMatchedRule = struct {
    /// Identifier of the rule that a simulated user matches.
    mobile_device_access_rule_id: ?[]const u8 = null,

    /// Name of a rule that a simulated user matches.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .mobile_device_access_rule_id = "MobileDeviceAccessRuleId",
        .name = "Name",
    };
};
