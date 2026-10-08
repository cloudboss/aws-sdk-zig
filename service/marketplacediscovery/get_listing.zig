const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListingAssociatedEntity = @import("listing_associated_entity.zig").ListingAssociatedEntity;
const ListingBadge = @import("listing_badge.zig").ListingBadge;
const Category = @import("category.zig").Category;
const FulfillmentOptionSummary = @import("fulfillment_option_summary.zig").FulfillmentOptionSummary;
const PricingModel = @import("pricing_model.zig").PricingModel;
const PricingUnit = @import("pricing_unit.zig").PricingUnit;
const PromotionalMedia = @import("promotional_media.zig").PromotionalMedia;
const SellerInformation = @import("seller_information.zig").SellerInformation;
const Resource = @import("resource.zig").Resource;
const ReviewSummary = @import("review_summary.zig").ReviewSummary;
const SellerEngagement = @import("seller_engagement.zig").SellerEngagement;
const UseCaseEntry = @import("use_case_entry.zig").UseCaseEntry;

pub const GetListingInput = struct {
    /// The unique identifier of the listing to retrieve.
    listing_id: []const u8,

    /// A BCP 47 language tag or comma-separated priority list specifying the
    /// preferred locale for response content. See `Locale` for supported values,
    /// constraints, fallback behavior, and the default locale. If omitted, the
    /// service returns content in the default locale.
    locale: ?[]const u8 = null,

    pub const json_field_names = .{
        .listing_id = "listingId",
        .locale = "locale",
    };
};

pub const GetListingOutput = struct {
    /// The products and offers associated with this listing. Each entity contains
    /// product and offer information.
    associated_entities: ?[]const ListingAssociatedEntity = null,

    /// Badges indicating special attributes of the listing, such as free tier
    /// eligibility, free trial availability, or Quick Launch support.
    badges: ?[]const ListingBadge = null,

    /// The name of the catalog that the listing belongs to.
    catalog: []const u8,

    /// The categories used to classify this listing into logical groups.
    categories: ?[]const Category = null,

    /// A summary of fulfillment options available for deploying or accessing the
    /// listing, such as AMI, SaaS, or Container.
    fulfillment_option_summaries: ?[]const FulfillmentOptionSummary = null,

    /// A list of key features that the listing offers to customers.
    highlights: ?[]const []const u8 = null,

    /// Optional guidance explaining how to use data in this listing. Primarily
    /// defines how to integrate with a multi-product listing.
    integration_guide: ?[]const u8 = null,

    /// The unique identifier of the listing.
    listing_id: []const u8,

    /// The human-readable display name of the listing.
    listing_name: []const u8,

    /// The locale of the returned content. Indicates whether the response contains
    /// content in the requested locale, or fell back to the default locale. See
    /// `Locale` for details.
    locale: ?[]const u8 = null,

    /// The URL of the logo thumbnail image for the listing.
    logo_thumbnail_url: []const u8,

    /// A detailed description of what the listing offers, in paragraph format.
    long_description: []const u8,

    /// The pricing models for offers associated with this listing, such as
    /// usage-based, contract, BYOL, or free.
    pricing_models: ?[]const PricingModel = null,

    /// The pricing units that define the billing dimensions for offers associated
    /// with this listing, such as users, hosts, or data.
    pricing_units: ?[]const PricingUnit = null,

    /// Embedded promotional media provided by the creator of the product, such as
    /// images and videos.
    promotional_media: ?[]const PromotionalMedia = null,

    /// The entity who created and published the listing.
    publisher: ?SellerInformation = null,

    /// Resources that provide further information about using the product or
    /// requesting support, such as documentation links, support contacts, and usage
    /// instructions.
    resources: ?[]const Resource = null,

    /// A summary of customer reviews available for the listing, including average
    /// rating and total review count by source.
    review_summary: ?ReviewSummary = null,

    /// Engagement options available to potential buyers, such as requesting a
    /// private offer or requesting a demo.
    seller_engagements: ?[]const SellerEngagement = null,

    /// A 1–3 sentence summary describing the key aspects of the listing.
    short_description: []const u8,

    /// Use cases associated with the listing, describing scenarios where the
    /// product can be applied.
    use_cases: ?[]const UseCaseEntry = null,

    pub const json_field_names = .{
        .associated_entities = "associatedEntities",
        .badges = "badges",
        .catalog = "catalog",
        .categories = "categories",
        .fulfillment_option_summaries = "fulfillmentOptionSummaries",
        .highlights = "highlights",
        .integration_guide = "integrationGuide",
        .listing_id = "listingId",
        .listing_name = "listingName",
        .locale = "locale",
        .logo_thumbnail_url = "logoThumbnailUrl",
        .long_description = "longDescription",
        .pricing_models = "pricingModels",
        .pricing_units = "pricingUnits",
        .promotional_media = "promotionalMedia",
        .publisher = "publisher",
        .resources = "resources",
        .review_summary = "reviewSummary",
        .seller_engagements = "sellerEngagements",
        .short_description = "shortDescription",
        .use_cases = "useCases",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetListingInput, options: CallOptions) !GetListingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aws-marketplace", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetListingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("discovery-marketplace", "Marketplace Discovery", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2026-02-05/getListing";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"listingId\":");
    try aws.json.writeValue(@TypeOf(input.listing_id), input.listing_id, allocator, &body_buf);
    has_prev = true;
    if (input.locale) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"locale\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetListingOutput {
    const result: GetListingOutput = try aws.json.parseJsonObject(
        GetListingOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
