const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PublicKey = @import("public_key.zig").PublicKey;

pub const ListPublicKeysInput = struct {
    /// Optionally specifies, in UTC, the end of the time range to look up public
    /// keys for
    /// CloudTrail digest files. If not specified, the current time is used.
    end_time: ?i64 = null,

    /// Reserved for future use.
    next_token: ?[]const u8 = null,

    /// Optionally specifies, in UTC, the start of the time range to look up public
    /// keys for
    /// CloudTrail digest files. If not specified, the current time is used, and the
    /// current public key is returned.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .next_token = "NextToken",
        .start_time = "StartTime",
    };
};

pub const ListPublicKeysOutput = struct {
    /// Reserved for future use.
    next_token: ?[]const u8 = null,

    /// Contains an array of PublicKey objects.
    ///
    /// The returned public keys may have validity time ranges that overlap.
    public_key_list: ?[]const PublicKey = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .public_key_list = "PublicKeyList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPublicKeysInput, options: CallOptions) !ListPublicKeysOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPublicKeysInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.ListPublicKeys");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPublicKeysOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListPublicKeysOutput, body, allocator);
}
