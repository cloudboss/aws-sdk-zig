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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
