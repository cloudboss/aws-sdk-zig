const std = @import("std");

pub const S3OutputFormat = enum {
    json,
    plain,
    w3_c,

    pub const json_field_names = .{
        .json = "json",
        .plain = "plain",
        .w3_c = "w3c",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .json => "json",
            .plain => "plain",
            .w3_c => "w3c",
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
