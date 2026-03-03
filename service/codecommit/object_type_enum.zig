const std = @import("std");

pub const ObjectTypeEnum = enum {
    file,
    directory,
    git_link,
    symbolic_link,

    pub const json_field_names = .{
        .file = "FILE",
        .directory = "DIRECTORY",
        .git_link = "GIT_LINK",
        .symbolic_link = "SYMBOLIC_LINK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .file => "FILE",
            .directory => "DIRECTORY",
            .git_link => "GIT_LINK",
            .symbolic_link => "SYMBOLIC_LINK",
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
