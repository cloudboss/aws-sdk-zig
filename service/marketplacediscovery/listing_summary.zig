const ListingSummaryAssociatedEntity = @import("listing_summary_associated_entity.zig").ListingSummaryAssociatedEntity;
const ListingBadge = @import("listing_badge.zig").ListingBadge;
const Category = @import("category.zig").Category;
const FulfillmentOptionSummary = @import("fulfillment_option_summary.zig").FulfillmentOptionSummary;
const PricingModel = @import("pricing_model.zig").PricingModel;
const PricingUnit = @import("pricing_unit.zig").PricingUnit;
const SellerInformation = @import("seller_information.zig").SellerInformation;
const ReviewSummary = @import("review_summary.zig").ReviewSummary;

/// Summary information about a listing returned by search operations, including
/// the listing name, description, badges, categories, pricing models, reviews,
/// and associated products.
pub const ListingSummary = struct {
    /// The products associated with this listing.
    associated_entities: []const ListingSummaryAssociatedEntity,

    /// Badges indicating special attributes of the listing.
    badges: []const ListingBadge,

    /// The name of the catalog that the listing belongs to.
    catalog: []const u8,

    /// The categories used to classify this listing into logical groups.
    categories: []const Category,

    /// A summary of fulfillment options available for the listing.
    fulfillment_option_summaries: []const FulfillmentOptionSummary,

    /// The unique identifier of the listing.
    listing_id: []const u8,

    /// The human-readable display name of the listing.
    listing_name: []const u8,

    /// The URL of the logo thumbnail image for the listing.
    logo_thumbnail_url: []const u8,

    /// The pricing models for offers associated with this listing.
    pricing_models: []const PricingModel,

    /// The pricing units that define the billing dimensions for offers associated
    /// with this listing.
    pricing_units: []const PricingUnit,

    /// The entity who created and published the listing.
    publisher: SellerInformation,

    /// A summary of customer reviews for the listing.
    review_summary: ReviewSummary,

    /// A 1–3 sentence summary describing the key aspects of the listing.
    short_description: []const u8,

    pub const json_field_names = .{
        .associated_entities = "associatedEntities",
        .badges = "badges",
        .catalog = "catalog",
        .categories = "categories",
        .fulfillment_option_summaries = "fulfillmentOptionSummaries",
        .listing_id = "listingId",
        .listing_name = "listingName",
        .logo_thumbnail_url = "logoThumbnailUrl",
        .pricing_models = "pricingModels",
        .pricing_units = "pricingUnits",
        .publisher = "publisher",
        .review_summary = "reviewSummary",
        .short_description = "shortDescription",
    };
};
