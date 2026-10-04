const std = @import("std");

pub const S3StorageClass = enum {
    standard,
    intelligent_tiering,
    glacier_ir,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .intelligent_tiering = "INTELLIGENT_TIERING",
        .glacier_ir = "GLACIER_IR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .intelligent_tiering => "INTELLIGENT_TIERING",
            .glacier_ir => "GLACIER_IR",
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
