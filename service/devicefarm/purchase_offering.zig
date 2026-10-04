const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OfferingTransaction = @import("offering_transaction.zig").OfferingTransaction;

pub const PurchaseOfferingInput = struct {
    /// The ID of the offering.
    offering_id: []const u8,

    /// The ID of the offering promotion to be applied to the purchase.
    offering_promotion_id: ?[]const u8 = null,

    /// The number of device slots to purchase in an offering request.
    quantity: i32,

    pub const json_field_names = .{
        .offering_id = "offeringId",
        .offering_promotion_id = "offeringPromotionId",
        .quantity = "quantity",
    };
};

pub const PurchaseOfferingOutput = struct {
    /// Represents the offering transaction for the purchase result.
    offering_transaction: ?OfferingTransaction = null,

    pub const json_field_names = .{
        .offering_transaction = "offeringTransaction",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PurchaseOfferingInput, options: CallOptions) !PurchaseOfferingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devicefarm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PurchaseOfferingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.PurchaseOffering");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PurchaseOfferingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PurchaseOfferingOutput, body, allocator);
}
