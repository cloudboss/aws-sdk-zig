const std = @import("std");

pub const EC2TagFilterType = enum {
    key_only,
    value_only,
    key_and_value,

    pub const json_field_names = .{
        .key_only = "KEY_ONLY",
        .value_only = "VALUE_ONLY",
        .key_and_value = "KEY_AND_VALUE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .key_only => "KEY_ONLY",
            .value_only => "VALUE_ONLY",
            .key_and_value => "KEY_AND_VALUE",
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
