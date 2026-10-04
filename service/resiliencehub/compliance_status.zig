const std = @import("std");

pub const ComplianceStatus = enum {
    policy_breached,
    policy_met,
    not_applicable,
    missing_policy,

    pub const json_field_names = .{
        .policy_breached = "PolicyBreached",
        .policy_met = "PolicyMet",
        .not_applicable = "NotApplicable",
        .missing_policy = "MissingPolicy",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .policy_breached => "PolicyBreached",
            .policy_met => "PolicyMet",
            .not_applicable => "NotApplicable",
            .missing_policy => "MissingPolicy",
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
