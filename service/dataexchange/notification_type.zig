const std = @import("std");

pub const NotificationType = enum {
    data_delay,
    data_update,
    deprecation,
    schema_change,

    pub const json_field_names = .{
        .data_delay = "DATA_DELAY",
        .data_update = "DATA_UPDATE",
        .deprecation = "DEPRECATION",
        .schema_change = "SCHEMA_CHANGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .data_delay => "DATA_DELAY",
            .data_update => "DATA_UPDATE",
            .deprecation => "DEPRECATION",
            .schema_change => "SCHEMA_CHANGE",
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
