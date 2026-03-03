const std = @import("std");

pub const SortByEnum = enum {
    repository_name,
    modified_date,

    pub const json_field_names = .{
        .repository_name = "repositoryName",
        .modified_date = "lastModifiedDate",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .repository_name => "repositoryName",
            .modified_date => "lastModifiedDate",
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
