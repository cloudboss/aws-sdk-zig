const std = @import("std");

pub const ResourceControlPolicyRestriction = enum {
    applicable,
    failed_to_evaluate_rcp,
    not_applicable,
    applied,

    pub const json_field_names = .{
        .applicable = "APPLICABLE",
        .failed_to_evaluate_rcp = "FAILED_TO_EVALUATE_RCP",
        .not_applicable = "NOT_APPLICABLE",
        .applied = "APPLIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .applicable => "APPLICABLE",
            .failed_to_evaluate_rcp => "FAILED_TO_EVALUATE_RCP",
            .not_applicable => "NOT_APPLICABLE",
            .applied => "APPLIED",
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
