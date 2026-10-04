const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrailInfo = @import("trail_info.zig").TrailInfo;

pub const ListTrailsInput = struct {
    /// The token to use to get the next page of results after a previous API call.
    /// This token
    /// must be passed in with the same parameters that were specified in the
    /// original call. For
    /// example, if the original call specified an AttributeKey of 'Username' with a
    /// value of
    /// 'root', the call with NextToken should include those same parameters.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
    };
};

pub const ListTrailsOutput = struct {
    /// The token to use to get the next page of results after a previous API call.
    /// If the token
    /// does not appear, there are no more results to return. The token must be
    /// passed in with the
    /// same parameters as the previous call. For example, if the original call
    /// specified an
    /// AttributeKey of 'Username' with a value of 'root', the call with NextToken
    /// should include
    /// those same parameters.
    next_token: ?[]const u8 = null,

    /// Returns the name, ARN, and home Region of trails in the current account.
    trails: ?[]const TrailInfo = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .trails = "Trails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrailsInput, options: CallOptions) !ListTrailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.ListTrails");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrailsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTrailsOutput, body, allocator);
}
