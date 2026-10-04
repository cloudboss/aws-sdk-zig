const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GeoMatchSet = @import("geo_match_set.zig").GeoMatchSet;

pub const GetGeoMatchSetInput = struct {
    /// The `GeoMatchSetId` of the GeoMatchSet that you want to get. `GeoMatchSetId`
    /// is returned by CreateGeoMatchSet and by
    /// ListGeoMatchSets.
    geo_match_set_id: []const u8,

    pub const json_field_names = .{
        .geo_match_set_id = "GeoMatchSetId",
    };
};

pub const GetGeoMatchSetOutput = struct {
    /// Information about the GeoMatchSet that you specified in the `GetGeoMatchSet`
    /// request. This includes the `Type`, which for a `GeoMatchContraint` is always
    /// `Country`, as well as the `Value`, which is the identifier for a specific
    /// country.
    geo_match_set: ?GeoMatchSet = null,

    pub const json_field_names = .{
        .geo_match_set = "GeoMatchSet",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGeoMatchSetInput, options: CallOptions) !GetGeoMatchSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "waf", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGeoMatchSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("waf", "WAF", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20150824.GetGeoMatchSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGeoMatchSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetGeoMatchSetOutput, body, allocator);
}
