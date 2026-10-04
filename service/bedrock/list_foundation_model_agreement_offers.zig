const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OfferType = @import("offer_type.zig").OfferType;
const Offer = @import("offer.zig").Offer;

pub const ListFoundationModelAgreementOffersInput = struct {
    /// Model Id of the foundation model.
    model_id: []const u8,

    /// Type of offer associated with the model.
    offer_type: ?OfferType = null,

    pub const json_field_names = .{
        .model_id = "modelId",
        .offer_type = "offerType",
    };
};

pub const ListFoundationModelAgreementOffersOutput = struct {
    /// Model Id of the foundation model.
    model_id: []const u8,

    /// List of the offers associated with the specified model.
    offers: ?[]const Offer = null,

    pub const json_field_names = .{
        .model_id = "modelId",
        .offers = "offers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFoundationModelAgreementOffersInput, options: CallOptions) !ListFoundationModelAgreementOffersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFoundationModelAgreementOffersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/list-foundation-model-agreement-offers/");
    try path_buf.appendSlice(allocator, input.model_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.offer_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "offerType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFoundationModelAgreementOffersOutput {
    const result: ListFoundationModelAgreementOffersOutput = try aws.json.parseJsonObject(
        ListFoundationModelAgreementOffersOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
