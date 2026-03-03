/// This field provides the associations' information for other entities with
/// the opportunity. These entities include identifiers for `AWSProducts`,
/// `Partner Solutions`, and `AWSMarketplaceOffers`.
pub const RelatedEntityIdentifiers = struct {
    /// Takes one value per opportunity. Each value is an Amazon Resource Name
    /// (ARN), in this format: `"offers":
    /// ["arn:aws:aws-marketplace:us-east-1:999999999999:AWSMarketplace/Offer/offer-sampleOffer32"]`.
    ///
    /// Use the
    /// [ListEntities](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/API_ListEntities.html) action in the Marketplace Catalog APIs for a list of offers in the associated Marketplace seller account.
    aws_marketplace_offers: ?[]const []const u8 = null,

    /// Enables the association of AWS Marketplace offer sets with the
    /// `Opportunity`. Offer sets allow grouping multiple related marketplace offers
    /// together for comprehensive solution packaging. Each value is an Amazon
    /// Resource Name (ARN) in this format:
    /// `arn:aws:aws-marketplace:us-east-1:999999999999:AWSMarketplace/OfferSet/offerset-sampleOfferSet32`.
    aws_marketplace_offer_sets: ?[]const []const u8 = null,

    /// Enables the association of specific Amazon Web Services products with the
    /// `Opportunity`. Partners can indicate the relevant Amazon Web Services
    /// products for the `Opportunity`'s solution and align with the customer's
    /// needs. Returns multiple values separated by commas. For example,
    /// `"AWSProducts" : ["AmazonRedshift", "AWSAppFabric", "AWSCleanRooms"]`.
    ///
    /// Use the file with the list of Amazon Web Services products hosted on GitHub:
    /// [ Amazon Web Services
    /// products](https://github.com/aws-samples/partner-crm-integration-samples/blob/main/resources/aws_products.json).
    aws_products: ?[]const []const u8 = null,

    /// Enables partner solutions or offerings' association with an opportunity. To
    /// associate a solution, provide the solution's unique identifier, which you
    /// can obtain with the `ListSolutions` operation.
    ///
    /// If the specific solution identifier is not available, you can use the value
    /// `Other` and provide details about the solution in the `otherSolutionOffered`
    /// field. But when the opportunity reaches the `Committed` stage or beyond, the
    /// `Other` value cannot be used, and a valid solution identifier must be
    /// provided.
    ///
    /// By associating the relevant solutions with the opportunity, you can
    /// communicate the offerings that are being considered or implemented to
    /// address the customer's business problem.
    solutions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .aws_marketplace_offers = "AwsMarketplaceOffers",
        .aws_marketplace_offer_sets = "AwsMarketplaceOfferSets",
        .aws_products = "AwsProducts",
        .solutions = "Solutions",
    };
};
