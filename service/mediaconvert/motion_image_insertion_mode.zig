const std = @import("std");

/// Choose the type of motion graphic asset that you are providing for your
/// overlay. You can choose either a .mov file or a series of .png files.
pub const MotionImageInsertionMode = enum {
    mov,
    png,

    pub const json_field_names = .{
        .mov = "MOV",
        .png = "PNG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mov => "MOV",
            .png => "PNG",
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
