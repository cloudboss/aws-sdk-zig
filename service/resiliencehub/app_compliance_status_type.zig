const std = @import("std");

pub const AppComplianceStatusType = enum {
    policy_breached,
    policy_met,
    not_assessed,
    changes_detected,
    not_applicable,
    missing_policy,

    pub const json_field_names = .{
        .policy_breached = "PolicyBreached",
        .policy_met = "PolicyMet",
        .not_assessed = "NotAssessed",
        .changes_detected = "ChangesDetected",
        .not_applicable = "NotApplicable",
        .missing_policy = "MissingPolicy",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .policy_breached => "PolicyBreached",
            .policy_met => "PolicyMet",
            .not_assessed => "NotAssessed",
            .changes_detected => "ChangesDetected",
            .not_applicable => "NotApplicable",
            .missing_policy => "MissingPolicy",
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
