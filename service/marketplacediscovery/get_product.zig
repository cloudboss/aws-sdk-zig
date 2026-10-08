const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Category = @import("category.zig").Category;
const DeployedOnAwsStatus = @import("deployed_on_aws_status.zig").DeployedOnAwsStatus;
const FulfillmentOptionSummary = @import("fulfillment_option_summary.zig").FulfillmentOptionSummary;
const SellerInformation = @import("seller_information.zig").SellerInformation;
const PromotionalMedia = @import("promotional_media.zig").PromotionalMedia;
const Resource = @import("resource.zig").Resource;
const SellerEngagement = @import("seller_engagement.zig").SellerEngagement;

pub const GetProductInput = struct {
    /// A BCP 47 language tag or comma-separated priority list specifying the
    /// preferred locale for response content. See `Locale` for supported values,
    /// constraints, fallback behavior, and the default locale. If omitted, the
    /// service returns content in the default locale.
    locale: ?[]const u8 = null,

    /// The unique identifier of the product to retrieve.
    product_id: []const u8,

    pub const json_field_names = .{
        .locale = "locale",
        .product_id = "productId",
    };
};

pub const GetProductOutput = struct {
    /// The name of the catalog that the product belongs to.
    catalog: []const u8,

    /// The categories used to classify this product into logical groups.
    categories: ?[]const Category = null,

    /// Indicates whether the product is deployed on AWS infrastructure.
    deployed_on_aws: DeployedOnAwsStatus,

    /// A summary of fulfillment options available for deploying or accessing the
    /// product, such as AMI, SaaS, or Container.
    fulfillment_option_summaries: ?[]const FulfillmentOptionSummary = null,

    /// A list of key features that the product offers to customers.
    highlights: ?[]const []const u8 = null,

    /// The default listing identifier associated with the product.
    listing_id: []const u8,

    /// The locale of the returned content. Indicates whether the response contains
    /// content in the requested locale, or fell back to the default locale. See
    /// `Locale` for details.
    locale: ?[]const u8 = null,

    /// The URL of the logo thumbnail image for the product.
    logo_thumbnail_url: []const u8,

    /// A detailed description of what the product does, in paragraph format.
    long_description: []const u8,

    /// The entity who manufactured the product.
    manufacturer: ?SellerInformation = null,

    /// The unique identifier of the product.
    product_id: []const u8,

    /// The human-readable display name of the product.
    product_name: []const u8,

    /// Embedded promotional media provided by the creator of the product, such as
    /// images and videos.
    promotional_media: ?[]const PromotionalMedia = null,

    /// Resources that provide further information about using the product or
    /// requesting support, such as documentation links, support contacts, and usage
    /// instructions.
    resources: ?[]const Resource = null,

    /// Engagement options available to potential buyers, such as requesting a
    /// private offer or requesting a demo.
    seller_engagements: ?[]const SellerEngagement = null,

    /// A 1–3 sentence summary describing the key aspects of the product.
    short_description: []const u8,

    pub const json_field_names = .{
        .catalog = "catalog",
        .categories = "categories",
        .deployed_on_aws = "deployedOnAws",
        .fulfillment_option_summaries = "fulfillmentOptionSummaries",
        .highlights = "highlights",
        .listing_id = "listingId",
        .locale = "locale",
        .logo_thumbnail_url = "logoThumbnailUrl",
        .long_description = "longDescription",
        .manufacturer = "manufacturer",
        .product_id = "productId",
        .product_name = "productName",
        .promotional_media = "promotionalMedia",
        .resources = "resources",
        .seller_engagements = "sellerEngagements",
        .short_description = "shortDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProductInput, options: CallOptions) !GetProductOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProductInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("discovery-marketplace", "Marketplace Discovery", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2026-02-05/getProduct";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.locale) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"locale\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"productId\":");
    try aws.json.writeValue(@TypeOf(input.product_id), input.product_id, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProductOutput {
    const result: GetProductOutput = try aws.json.parseJsonObject(
        GetProductOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
