const std = @import("std");

pub const InputMode = enum {
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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
