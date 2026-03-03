const std = @import("std");

pub const TrainingInputMode = enum {
    file,
    fast_file,
    pipe,

    pub const json_field_names = .{
        .file = "File",
        .fast_file = "FastFile",
        .pipe = "Pipe",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .file => "File",
            .fast_file => "FastFile",
            .pipe => "Pipe",
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
