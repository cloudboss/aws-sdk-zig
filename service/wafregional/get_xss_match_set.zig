const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const XssMatchSet = @import("xss_match_set.zig").XssMatchSet;

pub const GetXssMatchSetInput = struct {
    /// The `XssMatchSetId` of the XssMatchSet that you want to get. `XssMatchSetId`
    /// is returned by CreateXssMatchSet and by ListXssMatchSets.
    xss_match_set_id: []const u8,

    pub const json_field_names = .{
        .xss_match_set_id = "XssMatchSetId",
    };
};

pub const GetXssMatchSetOutput = struct {
    /// Information about the XssMatchSet that you specified in the `GetXssMatchSet`
    /// request.
    /// For more information, see the following topics:
    ///
    /// * XssMatchSet: Contains `Name`, `XssMatchSetId`, and an array of
    /// `XssMatchTuple` objects
    ///
    /// * XssMatchTuple: Each `XssMatchTuple` object contains `FieldToMatch` and
    /// `TextTransformation`
    ///
    /// * FieldToMatch: Contains `Data` and `Type`
    xss_match_set: ?XssMatchSet = null,

    pub const json_field_names = .{
        .xss_match_set = "XssMatchSet",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetXssMatchSetInput, options: CallOptions) !GetXssMatchSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetXssMatchSetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_Regional_20161128.GetXssMatchSet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetXssMatchSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetXssMatchSetOutput, body, allocator);
}
