const std = @import("std");

pub const ProductViewFilterBy = enum {
    full_text_search,
    owner,
    product_type,
    source_product_id,

    pub const json_field_names = .{
        .full_text_search = "FullTextSearch",
        .owner = "Owner",
        .product_type = "ProductType",
        .source_product_id = "SourceProductId",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .full_text_search => "FullTextSearch",
            .owner => "Owner",
            .product_type => "ProductType",
            .source_product_id => "SourceProductId",
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
