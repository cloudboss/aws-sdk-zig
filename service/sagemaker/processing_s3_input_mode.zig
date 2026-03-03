const std = @import("std");

pub const ProcessingS3InputMode = enum {
    pipe,
    file,

    pub const json_field_names = .{
        .pipe = "Pipe",
        .file = "File",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pipe => "Pipe",
            .file => "File",
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
