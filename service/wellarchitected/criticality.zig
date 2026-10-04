const std = @import("std");

pub const Criticality = enum {
    mission_critical,
    business_critical,
    non_critical,
    test_development,

    pub const json_field_names = .{
        .mission_critical = "MISSION_CRITICAL",
        .business_critical = "BUSINESS_CRITICAL",
        .non_critical = "NON_CRITICAL",
        .test_development = "TEST_DEVELOPMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mission_critical => "MISSION_CRITICAL",
            .business_critical => "BUSINESS_CRITICAL",
            .non_critical => "NON_CRITICAL",
            .test_development => "TEST_DEVELOPMENT",
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
