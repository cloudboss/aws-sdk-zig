const std = @import("std");

pub const ContainerFormat = enum {
    ts,
    fragmented_mp4,

    pub const json_field_names = .{
        .ts = "TS",
        .fragmented_mp4 = "FRAGMENTED_MP4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ts => "TS",
            .fragmented_mp4 => "FRAGMENTED_MP4",
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
