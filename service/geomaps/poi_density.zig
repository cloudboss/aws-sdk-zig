const std = @import("std");

pub const PoiDensity = enum {
    off,
    very_sparse,
    sparse,
    default,
    dense,
    very_dense,

    pub const json_field_names = .{
        .off = "Off",
        .very_sparse = "VerySparse",
        .sparse = "Sparse",
        .default = "Default",
        .dense = "Dense",
        .very_dense = "VeryDense",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .off => "Off",
            .very_sparse => "VerySparse",
            .sparse => "Sparse",
            .default => "Default",
            .dense => "Dense",
            .very_dense => "VeryDense",
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
