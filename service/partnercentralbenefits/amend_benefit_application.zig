const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Amendment = @import("amendment.zig").Amendment;

pub const AmendBenefitApplicationInput = struct {
    /// A descriptive reason explaining why the benefit application is being
    /// amended.
    amendment_reason: []const u8,

    /// A list of specific field amendments to apply to the benefit application.
    amendments: []const Amendment,

    /// The catalog identifier that specifies which benefit catalog the application
    /// belongs to.
    catalog: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotent processing of the
    /// amendment request.
    client_token: []const u8,

    /// The unique identifier of the benefit application to be amended.
    identifier: []const u8,

    /// The current revision number of the benefit application to ensure optimistic
    /// concurrency control.
    revision: []const u8,

    pub const json_field_names = .{
        .amendment_reason = "AmendmentReason",
        .amendments = "Amendments",
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .identifier = "Identifier",
        .revision = "Revision",
    };
};

pub const AmendBenefitApplicationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AmendBenefitApplicationInput, options: CallOptions) !AmendBenefitApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AmendBenefitApplicationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "PartnerCentralBenefitsService.AmendBenefitApplication");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AmendBenefitApplicationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
