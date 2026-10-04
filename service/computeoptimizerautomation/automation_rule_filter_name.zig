const std = @import("std");

pub const AutomationRuleFilterName = enum {
    name,
    recommended_action_type,
    status,
    rule_type,
    organization_configuration_rule_apply_order,
    account_id,

    pub const json_field_names = .{
        .name = "Name",
        .recommended_action_type = "RecommendedActionType",
        .status = "Status",
        .rule_type = "RuleType",
        .organization_configuration_rule_apply_order = "OrganizationConfigurationRuleApplyOrder",
        .account_id = "AccountId",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "Name",
            .recommended_action_type => "RecommendedActionType",
            .status => "Status",
            .rule_type => "RuleType",
            .organization_configuration_rule_apply_order => "OrganizationConfigurationRuleApplyOrder",
            .account_id => "AccountId",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
