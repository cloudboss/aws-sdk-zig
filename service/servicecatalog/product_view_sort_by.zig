const std = @import("std");

pub const ProductViewSortBy = enum {
    title,
    version_count,
    creation_date,

    pub const json_field_names = .{
        .title = "Title",
        .version_count = "VersionCount",
        .creation_date = "CreationDate",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .title => "Title",
            .version_count => "VersionCount",
            .creation_date => "CreationDate",
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
