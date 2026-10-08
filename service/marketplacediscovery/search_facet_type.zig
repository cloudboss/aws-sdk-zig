const std = @import("std");

pub const SearchFacetType = enum {
    average_customer_rating,
    category,
    publisher,
    fulfillment_option_type,
    pricing_model,
    pricing_unit,
    deployed_on_aws,
    number_of_products,

    pub const json_field_names = .{
        .average_customer_rating = "AVERAGE_CUSTOMER_RATING",
        .category = "CATEGORY",
        .publisher = "PUBLISHER",
        .fulfillment_option_type = "FULFILLMENT_OPTION_TYPE",
        .pricing_model = "PRICING_MODEL",
        .pricing_unit = "PRICING_UNIT",
        .deployed_on_aws = "DEPLOYED_ON_AWS",
        .number_of_products = "NUMBER_OF_PRODUCTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .average_customer_rating => "AVERAGE_CUSTOMER_RATING",
            .category => "CATEGORY",
            .publisher => "PUBLISHER",
            .fulfillment_option_type => "FULFILLMENT_OPTION_TYPE",
            .pricing_model => "PRICING_MODEL",
            .pricing_unit => "PRICING_UNIT",
            .deployed_on_aws => "DEPLOYED_ON_AWS",
            .number_of_products => "NUMBER_OF_PRODUCTS",
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
