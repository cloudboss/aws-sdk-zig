const std = @import("std");

pub const KeySpec = enum {
    key_exchange,
    signature,

    pub const json_field_names = .{
        .key_exchange = "KEY_EXCHANGE",
        .signature = "SIGNATURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .key_exchange => "KEY_EXCHANGE",
            .signature => "SIGNATURE",
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
