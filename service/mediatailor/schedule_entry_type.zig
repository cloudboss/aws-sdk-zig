const std = @import("std");

pub const ScheduleEntryType = enum {
    program,
    filler_slate,
    alternate_media,

    pub const json_field_names = .{
        .program = "PROGRAM",
        .filler_slate = "FILLER_SLATE",
        .alternate_media = "ALTERNATE_MEDIA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .program => "PROGRAM",
            .filler_slate => "FILLER_SLATE",
            .alternate_media => "ALTERNATE_MEDIA",
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
