const std = @import("std");

pub const OrderByFieldType = enum {
    relevance,
    name,
    size,
    created_timestamp,
    modified_timestamp,

    pub const json_field_names = .{
        .relevance = "RELEVANCE",
        .name = "NAME",
        .size = "SIZE",
        .created_timestamp = "CREATED_TIMESTAMP",
        .modified_timestamp = "MODIFIED_TIMESTAMP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .relevance => "RELEVANCE",
            .name => "NAME",
            .size => "SIZE",
            .created_timestamp => "CREATED_TIMESTAMP",
            .modified_timestamp => "MODIFIED_TIMESTAMP",
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
