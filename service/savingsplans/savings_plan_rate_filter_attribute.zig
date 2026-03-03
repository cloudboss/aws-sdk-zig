const std = @import("std");

pub const SavingsPlanRateFilterAttribute = enum {
    region,
    instance_family,
    instance_type,
    product_description,
    tenancy,
    product_id,

    pub const json_field_names = .{
        .region = "region",
        .instance_family = "instanceFamily",
        .instance_type = "instanceType",
        .product_description = "productDescription",
        .tenancy = "tenancy",
        .product_id = "productId",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .region => "region",
            .instance_family => "instanceFamily",
            .instance_type => "instanceType",
            .product_description => "productDescription",
            .tenancy => "tenancy",
            .product_id => "productId",
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
