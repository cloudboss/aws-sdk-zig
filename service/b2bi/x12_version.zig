const std = @import("std");

pub const X12Version = enum {
    version_4010,
    version_4030,
    version_4050,
    version_4060,
    version_5010,
    version_5010_hipaa,

    pub const json_field_names = .{
        .version_4010 = "VERSION_4010",
        .version_4030 = "VERSION_4030",
        .version_4050 = "VERSION_4050",
        .version_4060 = "VERSION_4060",
        .version_5010 = "VERSION_5010",
        .version_5010_hipaa = "VERSION_5010_HIPAA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .version_4010 => "VERSION_4010",
            .version_4030 => "VERSION_4030",
            .version_4050 => "VERSION_4050",
            .version_4060 => "VERSION_4060",
            .version_5010 => "VERSION_5010",
            .version_5010_hipaa => "VERSION_5010_HIPAA",
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
