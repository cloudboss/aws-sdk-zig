const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IPSetSummary = @import("ip_set_summary.zig").IPSetSummary;

pub const ListIPSetsInput = struct {
    /// Specifies the number of `IPSet` objects that you want AWS WAF to return for
    /// this request. If you have more
    /// `IPSet` objects than the number you specify for `Limit`, the response
    /// includes a
    /// `NextMarker` value that you can use to get another batch of `IPSet` objects.
    limit: ?i32 = null,

    /// AWS WAF returns a `NextMarker` value in the response that allows you to
    /// list another group of `IPSets`. For the second and subsequent
    /// `ListIPSets` requests, specify the value of `NextMarker` from the
    /// previous response to get information about another batch of `IPSets`.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .limit = "Limit",
        .next_marker = "NextMarker",
    };
};

pub const ListIPSetsOutput = struct {
    /// An array of IPSetSummary objects.
    ip_sets: ?[]const IPSetSummary = null,

    /// To list more `IPSet` objects, submit another `ListIPSets`
    /// request, and in the next request use the `NextMarker` response value as the
    /// `NextMarker` value.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .ip_sets = "IPSets",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListIPSetsInput, options: CallOptions) !ListIPSetsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListIPSetsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_20150824.ListIPSets");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListIPSetsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListIPSetsOutput, body, allocator);
}
