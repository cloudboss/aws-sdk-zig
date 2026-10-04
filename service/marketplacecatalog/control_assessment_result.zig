const std = @import("std");

pub const ControlAssessmentResult = enum {
    pass,
    fail,
    not_executed,
    exemption_pass,

    pub const json_field_names = .{
        .pass = "PASS",
        .fail = "FAIL",
        .not_executed = "NOT_EXECUTED",
        .exemption_pass = "EXEMPTION_PASS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pass => "PASS",
            .fail => "FAIL",
            .not_executed => "NOT_EXECUTED",
            .exemption_pass => "EXEMPTION_PASS",
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
