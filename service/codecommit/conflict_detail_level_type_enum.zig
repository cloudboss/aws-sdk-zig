const std = @import("std");

pub const ConflictDetailLevelTypeEnum = enum {
    file_level,
    line_level,

    pub const json_field_names = .{
        .file_level = "FILE_LEVEL",
        .line_level = "LINE_LEVEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .file_level => "FILE_LEVEL",
            .line_level => "LINE_LEVEL",
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
