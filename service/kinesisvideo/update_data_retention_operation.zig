const std = @import("std");

pub const UpdateDataRetentionOperation = enum {
    increase_data_retention,
    decrease_data_retention,

    pub const json_field_names = .{
        .increase_data_retention = "INCREASE_DATA_RETENTION",
        .decrease_data_retention = "DECREASE_DATA_RETENTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .increase_data_retention => "INCREASE_DATA_RETENTION",
            .decrease_data_retention => "DECREASE_DATA_RETENTION",
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
