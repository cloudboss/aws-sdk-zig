const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetSignedBluinsightsUrlInput = struct {};

pub const GetSignedBluinsightsUrlOutput = struct {
    /// Single sign-on AWS Blu Insights URL.
    signed_bi_url: []const u8,

    pub const json_field_names = .{
        .signed_bi_url = "signedBiUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSignedBluinsightsUrlInput, options: CallOptions) !GetSignedBluinsightsUrlOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "m2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSignedBluinsightsUrlInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("m2", "m2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/signed-bi-url";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSignedBluinsightsUrlOutput {
    var result: GetSignedBluinsightsUrlOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSignedBluinsightsUrlOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
