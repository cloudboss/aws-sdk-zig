const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PricingOption = @import("pricing_option.zig").PricingOption;
const PricingResult = @import("pricing_result.zig").PricingResult;

pub const GetRenewalPricingInput = struct {
    /// The ID or ARN of the Outpost.
    outpost_identifier: []const u8,

    pub const json_field_names = .{
        .outpost_identifier = "OutpostIdentifier",
    };
};

pub const GetRenewalPricingOutput = struct {
    /// The pricing options for the specified Outpost.
    pricing_options: ?[]const PricingOption = null,

    /// The result of the pricing request.
    pricing_result: ?PricingResult = null,

    pub const json_field_names = .{
        .pricing_options = "PricingOptions",
        .pricing_result = "PricingResult",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRenewalPricingInput, options: CallOptions) !GetRenewalPricingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "outposts", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRenewalPricingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("outposts", "Outposts", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/outpost/");
    try path_buf.appendSlice(allocator, input.outpost_identifier);
    try path_buf.appendSlice(allocator, "/renewal-pricing");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRenewalPricingOutput {
    const result: GetRenewalPricingOutput = try aws.json.parseJsonObject(
        GetRenewalPricingOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
