const std = @import("std");

pub const SNOMEDCTAttributeType = enum {
    acuity,
    quality,
    direction,
    system_organ_site,
    test_value,
    test_unit,

    pub const json_field_names = .{
        .acuity = "ACUITY",
        .quality = "QUALITY",
        .direction = "DIRECTION",
        .system_organ_site = "SYSTEM_ORGAN_SITE",
        .test_value = "TEST_VALUE",
        .test_unit = "TEST_UNIT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .acuity => "ACUITY",
            .quality => "QUALITY",
            .direction => "DIRECTION",
            .system_organ_site => "SYSTEM_ORGAN_SITE",
            .test_value => "TEST_VALUE",
            .test_unit => "TEST_UNIT",
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
