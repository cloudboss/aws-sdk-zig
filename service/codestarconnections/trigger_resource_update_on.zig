const std = @import("std");

pub const TriggerResourceUpdateOn = enum {
    any_change,
    file_change,

    pub const json_field_names = .{
        .any_change = "ANY_CHANGE",
        .file_change = "FILE_CHANGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .any_change => "ANY_CHANGE",
            .file_change => "FILE_CHANGE",
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
