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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
