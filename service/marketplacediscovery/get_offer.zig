const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OfferAssociatedEntity = @import("offer_associated_entity.zig").OfferAssociatedEntity;
const PurchaseOptionBadge = @import("purchase_option_badge.zig").PurchaseOptionBadge;
const PricingModel = @import("pricing_model.zig").PricingModel;
const SellerInformation = @import("seller_information.zig").SellerInformation;

pub const GetOfferInput = struct {
    /// A BCP 47 language tag or comma-separated priority list specifying the
    /// preferred locale for response content. See `Locale` for supported values,
    /// constraints, fallback behavior, and the default locale. If omitted, the
    /// service returns content in the default locale.
    locale: ?[]const u8 = null,

    /// The unique identifier of the offer to retrieve.
    offer_id: []const u8,

    pub const json_field_names = .{
        .locale = "locale",
        .offer_id = "offerId",
    };
};

pub const GetOfferOutput = struct {
    /// An encoded string to be passed by the acceptor of the terms when creating an
    /// agreement.
    agreement_proposal_id: []const u8,

    /// The products and offer sets associated with this offer.
    associated_entities: ?[]const OfferAssociatedEntity = null,

    /// The date and time when the offer became available to the buyer.
    available_from_time: ?i64 = null,

    /// Badges indicating special attributes of the offer, such as private pricing,
    /// future dated, or replacement offer.
    badges: ?[]const PurchaseOptionBadge = null,

    /// The name of the catalog that the offer belongs to.
    catalog: []const u8,

    /// The date and time until when the offer can be procured. This value is null
    /// for offers that never expire.
    expiration_time: ?i64 = null,

    /// The locale of the returned content. Indicates whether the response contains
    /// content in the requested locale, or fell back to the default locale. See
    /// `Locale` for details.
    locale: ?[]const u8 = null,

    /// The unique identifier of the offer.
    offer_id: []const u8,

    /// The display name of the offer. This is free-form text provided by the
    /// seller.
    offer_name: ?[]const u8 = null,

    /// The pricing model that determines how buyers are charged, such as
    /// usage-based, contract, BYOL, or free.
    pricing_model: ?PricingModel = null,

    /// The identifier of the existing agreement that this offer would replace.
    /// Enables agreement-based offer functionality.
    replacement_agreement_id: ?[]const u8 = null,

    /// The entity responsible for selling the product under this offer.
    seller_of_record: ?SellerInformation = null,

    pub const json_field_names = .{
        .agreement_proposal_id = "agreementProposalId",
        .associated_entities = "associatedEntities",
        .available_from_time = "availableFromTime",
        .badges = "badges",
        .catalog = "catalog",
        .expiration_time = "expirationTime",
        .locale = "locale",
        .offer_id = "offerId",
        .offer_name = "offerName",
        .pricing_model = "pricingModel",
        .replacement_agreement_id = "replacementAgreementId",
        .seller_of_record = "sellerOfRecord",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOfferInput, options: CallOptions) !GetOfferOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOfferInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("discovery-marketplace", "Marketplace Discovery", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2026-02-05/getOffer";

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
    try body_buf.appendSlice(allocator, "\"offerId\":");
    try aws.json.writeValue(@TypeOf(input.offer_id), input.offer_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOfferOutput {
    const result: GetOfferOutput = try aws.json.parseJsonObject(
        GetOfferOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
