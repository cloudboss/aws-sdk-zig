const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GeoMatchSet = @import("geo_match_set.zig").GeoMatchSet;

pub const CreateGeoMatchSetInput = struct {
    /// The value returned by the most recent call to GetChangeToken.
    change_token: []const u8,

    /// A friendly name or description of the GeoMatchSet. You can't change `Name`
    /// after you create the `GeoMatchSet`.
    name: []const u8,

    pub const json_field_names = .{
        .change_token = "ChangeToken",
        .name = "Name",
    };
};

pub const CreateGeoMatchSetOutput = struct {
    /// The `ChangeToken` that you used to submit the `CreateGeoMatchSet` request.
    /// You can also use this value
    /// to query the status of the request. For more information, see
    /// GetChangeTokenStatus.
    change_token: ?[]const u8 = null,

    /// The GeoMatchSet returned in the `CreateGeoMatchSet` response. The
    /// `GeoMatchSet` contains no `GeoMatchConstraints`.
    geo_match_set: ?GeoMatchSet = null,

    pub const json_field_names = .{
        .change_token = "ChangeToken",
        .geo_match_set = "GeoMatchSet",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGeoMatchSetInput, options: CallOptions) !CreateGeoMatchSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "waf-regional", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGeoMatchSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("waf-regional", "WAF Regional", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_Regional_20161128.CreateGeoMatchSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGeoMatchSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateGeoMatchSetOutput, body, allocator);
}
