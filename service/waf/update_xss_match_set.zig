const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const XssMatchSetUpdate = @import("xss_match_set_update.zig").XssMatchSetUpdate;

pub const UpdateXssMatchSetInput = struct {
    /// The value returned by the most recent call to GetChangeToken.
    change_token: []const u8,

    /// An array of `XssMatchSetUpdate` objects that you want to insert into or
    /// delete from an
    /// XssMatchSet. For more information, see the applicable data
    /// types:
    ///
    /// * XssMatchSetUpdate: Contains `Action` and `XssMatchTuple`
    ///
    /// * XssMatchTuple: Contains `FieldToMatch` and `TextTransformation`
    ///
    /// * FieldToMatch: Contains `Data` and `Type`
    updates: []const XssMatchSetUpdate,

    /// The `XssMatchSetId` of the `XssMatchSet` that you want to update.
    /// `XssMatchSetId` is returned by CreateXssMatchSet and by ListXssMatchSets.
    xss_match_set_id: []const u8,

    pub const json_field_names = .{
        .change_token = "ChangeToken",
        .updates = "Updates",
        .xss_match_set_id = "XssMatchSetId",
    };
};

pub const UpdateXssMatchSetOutput = struct {
    /// The `ChangeToken` that you used to submit the `UpdateXssMatchSet` request.
    /// You can also use this value
    /// to query the status of the request. For more information, see
    /// GetChangeTokenStatus.
    change_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .change_token = "ChangeToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateXssMatchSetInput, options: CallOptions) !UpdateXssMatchSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateXssMatchSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20150824.UpdateXssMatchSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateXssMatchSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateXssMatchSetOutput, body, allocator);
}
