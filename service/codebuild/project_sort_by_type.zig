const std = @import("std");

pub const ProjectSortByType = enum {
    name,
    created_time,
    last_modified_time,

    pub const json_field_names = .{
        .name = "NAME",
        .created_time = "CREATED_TIME",
        .last_modified_time = "LAST_MODIFIED_TIME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "NAME",
            .created_time => "CREATED_TIME",
            .last_modified_time => "LAST_MODIFIED_TIME",
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
