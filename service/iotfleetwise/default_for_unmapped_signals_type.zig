const std = @import("std");

pub const DefaultForUnmappedSignalsType = enum {
    custom_decoding,

    pub const json_field_names = .{
        .custom_decoding = "CUSTOM_DECODING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom_decoding => "CUSTOM_DECODING",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
