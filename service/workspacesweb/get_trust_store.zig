const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrustStore = @import("trust_store.zig").TrustStore;

pub const GetTrustStoreInput = struct {
    /// The ARN of the trust store.
    trust_store_arn: []const u8,

    pub const json_field_names = .{
        .trust_store_arn = "trustStoreArn",
    };
};

pub const GetTrustStoreOutput = struct {
    /// The trust store.
    trust_store: ?TrustStore = null,

    pub const json_field_names = .{
        .trust_store = "trustStore",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTrustStoreInput, options: CallOptions) !GetTrustStoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces-web", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTrustStoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces-web", "WorkSpaces Web", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/trustStores/");
    try path_buf.appendSlice(allocator, input.trust_store_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTrustStoreOutput {
    var result: GetTrustStoreOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTrustStoreOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
