const std = @import("std");

pub const LayerFailureCode = enum {
    invalid_layer_digest,
    missing_layer_digest,

    pub const json_field_names = .{
        .invalid_layer_digest = "InvalidLayerDigest",
        .missing_layer_digest = "MissingLayerDigest",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_layer_digest => "InvalidLayerDigest",
            .missing_layer_digest => "MissingLayerDigest",
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
