const std = @import("std");

pub const ScanMode = enum {
    progressive,
    interlace,
    progressive_segmented_frame,

    pub const json_field_names = .{
        .progressive = "progressive",
        .interlace = "interlace",
        .progressive_segmented_frame = "progressive-segmented-frame",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .progressive => "progressive",
            .interlace => "interlace",
            .progressive_segmented_frame => "progressive-segmented-frame",
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
