const std = @import("std");

pub const TransformSortColumnType = enum {
    name,
    transform_type,
    status,
    created,
    last_modified,

    pub const json_field_names = .{
        .name = "NAME",
        .transform_type = "TRANSFORM_TYPE",
        .status = "STATUS",
        .created = "CREATED",
        .last_modified = "LAST_MODIFIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "NAME",
            .transform_type => "TRANSFORM_TYPE",
            .status => "STATUS",
            .created => "CREATED",
            .last_modified => "LAST_MODIFIED",
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
