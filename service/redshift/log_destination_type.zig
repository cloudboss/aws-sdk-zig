const std = @import("std");

pub const LogDestinationType = enum {
    s3,
    cloudwatch,
    s3_table,

    pub const json_field_names = .{
        .s3 = "s3",
        .cloudwatch = "cloudwatch",
        .s3_table = "s3table",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .s3 => "s3",
            .cloudwatch => "cloudwatch",
            .s3_table => "s3table",
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
