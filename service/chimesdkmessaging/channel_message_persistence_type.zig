const std = @import("std");

pub const ChannelMessagePersistenceType = enum {
    persistent,
    non_persistent,

    pub const json_field_names = .{
        .persistent = "PERSISTENT",
        .non_persistent = "NON_PERSISTENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .persistent => "PERSISTENT",
            .non_persistent => "NON_PERSISTENT",
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
