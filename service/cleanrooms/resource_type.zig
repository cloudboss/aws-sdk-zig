const std = @import("std");

pub const ResourceType = enum {
    configured_table,
    collaboration,
    membership,
    configured_table_association,

    pub const json_field_names = .{
        .configured_table = "CONFIGURED_TABLE",
        .collaboration = "COLLABORATION",
        .membership = "MEMBERSHIP",
        .configured_table_association = "CONFIGURED_TABLE_ASSOCIATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .configured_table => "CONFIGURED_TABLE",
            .collaboration => "COLLABORATION",
            .membership => "MEMBERSHIP",
            .configured_table_association => "CONFIGURED_TABLE_ASSOCIATION",
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
