const std = @import("std");

pub const SavingsPlanRateFilterName = enum {
    region,
    instance_type,
    product_description,
    tenancy,
    product_type,
    service_code,
    usage_type,
    operation,

    pub const json_field_names = .{
        .region = "region",
        .instance_type = "instanceType",
        .product_description = "productDescription",
        .tenancy = "tenancy",
        .product_type = "productType",
        .service_code = "serviceCode",
        .usage_type = "usageType",
        .operation = "operation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .region => "region",
            .instance_type => "instanceType",
            .product_description => "productDescription",
            .tenancy => "tenancy",
            .product_type => "productType",
            .service_code => "serviceCode",
            .usage_type => "usageType",
            .operation => "operation",
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
