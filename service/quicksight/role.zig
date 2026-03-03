const std = @import("std");

pub const Role = enum {
    admin,
    author,
    reader,
    admin_pro,
    author_pro,
    reader_pro,

    pub const json_field_names = .{
        .admin = "ADMIN",
        .author = "AUTHOR",
        .reader = "READER",
        .admin_pro = "ADMIN_PRO",
        .author_pro = "AUTHOR_PRO",
        .reader_pro = "READER_PRO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .admin => "ADMIN",
            .author => "AUTHOR",
            .reader => "READER",
            .admin_pro => "ADMIN_PRO",
            .author_pro => "AUTHOR_PRO",
            .reader_pro => "READER_PRO",
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
