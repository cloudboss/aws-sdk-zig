const std = @import("std");

pub const EncodingTypeValue = enum {
    plain,
    plain_dictionary,
    rle_dictionary,

    pub const json_field_names = .{
        .plain = "plain",
        .plain_dictionary = "plain-dictionary",
        .rle_dictionary = "rle-dictionary",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .plain => "plain",
            .plain_dictionary => "plain-dictionary",
            .rle_dictionary => "rle-dictionary",
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
