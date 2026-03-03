const std = @import("std");

pub const ContainerFormat = enum {
    fragmented_mp4,
    mpeg_ts,

    pub const json_field_names = .{
        .fragmented_mp4 = "FRAGMENTED_MP4",
        .mpeg_ts = "MPEG_TS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fragmented_mp4 => "FRAGMENTED_MP4",
            .mpeg_ts => "MPEG_TS",
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
