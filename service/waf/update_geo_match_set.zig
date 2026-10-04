const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GeoMatchSetUpdate = @import("geo_match_set_update.zig").GeoMatchSetUpdate;

pub const UpdateGeoMatchSetInput = struct {
    /// The value returned by the most recent call to GetChangeToken.
    change_token: []const u8,

    /// The `GeoMatchSetId` of the GeoMatchSet that you want to update.
    /// `GeoMatchSetId` is returned by CreateGeoMatchSet and by
    /// ListGeoMatchSets.
    geo_match_set_id: []const u8,

    /// An array of `GeoMatchSetUpdate` objects that you want to insert into or
    /// delete from an GeoMatchSet.
    /// For more information, see the applicable data types:
    ///
    /// * GeoMatchSetUpdate: Contains `Action` and `GeoMatchConstraint`
    ///
    /// * GeoMatchConstraint: Contains `Type` and `Value`
    ///
    /// You can have only one `Type` and `Value` per `GeoMatchConstraint`. To add
    /// multiple countries, include multiple `GeoMatchSetUpdate` objects in your
    /// request.
    updates: []const GeoMatchSetUpdate,

    pub const json_field_names = .{
        .change_token = "ChangeToken",
        .geo_match_set_id = "GeoMatchSetId",
        .updates = "Updates",
    };
};

pub const UpdateGeoMatchSetOutput = struct {
    /// The `ChangeToken` that you used to submit the `UpdateGeoMatchSet` request.
    /// You can also use this value
    /// to query the status of the request. For more information, see
    /// GetChangeTokenStatus.
    change_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .change_token = "ChangeToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGeoMatchSetInput, options: CallOptions) !UpdateGeoMatchSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGeoMatchSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20150824.UpdateGeoMatchSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGeoMatchSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateGeoMatchSetOutput, body, allocator);
}
