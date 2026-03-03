/// Describes a work team of a vendor that does the labelling job.
pub const SubscribedWorkteam = struct {
    /// Marketplace product listing ID.
    listing_id: ?[]const u8 = null,

    /// The description of the vendor from the Amazon Marketplace.
    marketplace_description: ?[]const u8 = null,

    /// The title of the service provided by the vendor in the Amazon Marketplace.
    marketplace_title: ?[]const u8 = null,

    /// The name of the vendor in the Amazon Marketplace.
    seller_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the vendor that you have subscribed.
    workteam_arn: []const u8,

    pub const json_field_names = .{
        .listing_id = "ListingId",
        .marketplace_description = "MarketplaceDescription",
        .marketplace_title = "MarketplaceTitle",
        .seller_name = "SellerName",
        .workteam_arn = "WorkteamArn",
    };
};
