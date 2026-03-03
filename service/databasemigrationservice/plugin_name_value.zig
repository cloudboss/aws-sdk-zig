const std = @import("std");

pub const PluginNameValue = enum {
    no_preference,
    test_decoding,
    pglogical,

    pub const json_field_names = .{
        .no_preference = "no-preference",
        .test_decoding = "test-decoding",
        .pglogical = "pglogical",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_preference => "no-preference",
            .test_decoding => "test-decoding",
            .pglogical => "pglogical",
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
