const std = @import("std");

pub const DatasetActionType = enum {
    query,
    container,

    pub const json_field_names = .{
        .query = "QUERY",
        .container = "CONTAINER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .query => "QUERY",
            .container => "CONTAINER",
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
