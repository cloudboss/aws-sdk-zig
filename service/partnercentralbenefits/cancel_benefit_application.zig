const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CancelBenefitApplicationInput = struct {
    /// The catalog identifier that specifies which benefit catalog the application
    /// belongs to.
    catalog: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotent processing of the
    /// cancellation request.
    client_token: []const u8,

    /// The unique identifier of the benefit application to cancel.
    identifier: []const u8,

    /// A descriptive reason explaining why the benefit application is being
    /// cancelled.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .identifier = "Identifier",
        .reason = "Reason",
    };
};

pub const CancelBenefitApplicationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelBenefitApplicationInput, options: CallOptions) !CancelBenefitApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelBenefitApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-benefits", "PartnerCentral Benefits", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralBenefitsService.CancelBenefitApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelBenefitApplicationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
