const std = @import("std");

pub const VectorDistanceFunction = enum {
    cosine,
    dot_product,
    euclidean,

    pub const json_field_names = .{
        .cosine = "COSINE",
        .dot_product = "DOT_PRODUCT",
        .euclidean = "EUCLIDEAN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cosine => "COSINE",
            .dot_product => "DOT_PRODUCT",
            .euclidean => "EUCLIDEAN",
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
