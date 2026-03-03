const std = @import("std");

pub const ResourceType = enum {
    jar,
    file,
    archive,

    pub const json_field_names = .{
        .jar = "JAR",
        .file = "FILE",
        .archive = "ARCHIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .jar => "JAR",
            .file => "FILE",
            .archive => "ARCHIVE",
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
