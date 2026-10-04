const std = @import("std");

pub const RelatedEntityType = enum {
    solutions,
    aws_products,
    aws_marketplace_offers,
    aws_marketplace_offer_sets,
    aws_marketplace_solutions,
    aws_marketplace_products,

    pub const json_field_names = .{
        .solutions = "Solutions",
        .aws_products = "AwsProducts",
        .aws_marketplace_offers = "AwsMarketplaceOffers",
        .aws_marketplace_offer_sets = "AwsMarketplaceOfferSets",
        .aws_marketplace_solutions = "AwsMarketplaceSolutions",
        .aws_marketplace_products = "AwsMarketplaceProducts",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .solutions => "Solutions",
            .aws_products => "AwsProducts",
            .aws_marketplace_offers => "AwsMarketplaceOffers",
            .aws_marketplace_offer_sets => "AwsMarketplaceOfferSets",
            .aws_marketplace_solutions => "AwsMarketplaceSolutions",
            .aws_marketplace_products => "AwsMarketplaceProducts",
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
