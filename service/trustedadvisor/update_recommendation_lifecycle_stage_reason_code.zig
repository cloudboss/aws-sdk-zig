const std = @import("std");

pub const UpdateRecommendationLifecycleStageReasonCode = enum {
    non_critical_account,
    temporary_account,
    valid_business_case,
    other_methods_available,
    low_priority,
    not_applicable,
    other,

    pub const json_field_names = .{
        .non_critical_account = "non_critical_account",
        .temporary_account = "temporary_account",
        .valid_business_case = "valid_business_case",
        .other_methods_available = "other_methods_available",
        .low_priority = "low_priority",
        .not_applicable = "not_applicable",
        .other = "other",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .non_critical_account => "non_critical_account",
            .temporary_account => "temporary_account",
            .valid_business_case => "valid_business_case",
            .other_methods_available => "other_methods_available",
            .low_priority => "low_priority",
            .not_applicable => "not_applicable",
            .other => "other",
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
