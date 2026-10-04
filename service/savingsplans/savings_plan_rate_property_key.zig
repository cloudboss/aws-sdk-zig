const std = @import("std");

pub const SavingsPlanRatePropertyKey = enum {
    region,
    instance_type,
    instance_family,
    product_description,
    tenancy,

    pub const json_field_names = .{
        .region = "region",
        .instance_type = "instanceType",
        .instance_family = "instanceFamily",
        .product_description = "productDescription",
        .tenancy = "tenancy",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .region => "region",
            .instance_type => "instanceType",
            .instance_family => "instanceFamily",
            .product_description => "productDescription",
            .tenancy => "tenancy",
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
