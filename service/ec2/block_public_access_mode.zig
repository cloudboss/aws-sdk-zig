const std = @import("std");

pub const BlockPublicAccessMode = enum {
    off,
    block_bidirectional,
    block_ingress,

    pub const json_field_names = .{
        .off = "off",
        .block_bidirectional = "block-bidirectional",
        .block_ingress = "block-ingress",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .off => "off",
            .block_bidirectional => "block-bidirectional",
            .block_ingress => "block-ingress",
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
