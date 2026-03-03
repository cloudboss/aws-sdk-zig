const std = @import("std");

pub const AccountLimitType = enum {
    max_health_checks_by_owner,
    max_hosted_zones_by_owner,
    max_traffic_policy_instances_by_owner,
    max_reusable_delegation_sets_by_owner,
    max_traffic_policies_by_owner,

    pub const json_field_names = .{
        .max_health_checks_by_owner = "MAX_HEALTH_CHECKS_BY_OWNER",
        .max_hosted_zones_by_owner = "MAX_HOSTED_ZONES_BY_OWNER",
        .max_traffic_policy_instances_by_owner = "MAX_TRAFFIC_POLICY_INSTANCES_BY_OWNER",
        .max_reusable_delegation_sets_by_owner = "MAX_REUSABLE_DELEGATION_SETS_BY_OWNER",
        .max_traffic_policies_by_owner = "MAX_TRAFFIC_POLICIES_BY_OWNER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .max_health_checks_by_owner => "MAX_HEALTH_CHECKS_BY_OWNER",
            .max_hosted_zones_by_owner => "MAX_HOSTED_ZONES_BY_OWNER",
            .max_traffic_policy_instances_by_owner => "MAX_TRAFFIC_POLICY_INSTANCES_BY_OWNER",
            .max_reusable_delegation_sets_by_owner => "MAX_REUSABLE_DELEGATION_SETS_BY_OWNER",
            .max_traffic_policies_by_owner => "MAX_TRAFFIC_POLICIES_BY_OWNER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
