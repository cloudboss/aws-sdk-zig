pub const RelatedEntityType = enum {
    solutions,
    aws_products,
    aws_marketplace_offers,
    aws_marketplace_offer_sets,

    pub const json_field_names = .{
        .solutions = "SOLUTIONS",
        .aws_products = "AWS_PRODUCTS",
        .aws_marketplace_offers = "AWS_MARKETPLACE_OFFERS",
        .aws_marketplace_offer_sets = "AWS_MARKETPLACE_OFFER_SETS",
    };
};
