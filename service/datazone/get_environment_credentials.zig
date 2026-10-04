const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetEnvironmentCredentialsInput = struct {
    /// The ID of the Amazon DataZone domain in which this environment and its
    /// credentials exist.
    domain_identifier: []const u8,

    /// The ID of the environment whose credentials this operation gets.
    environment_identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .environment_identifier = "environmentIdentifier",
    };
};

pub const GetEnvironmentCredentialsOutput = struct {
    /// The access key ID of the environment.
    access_key_id: ?[]const u8 = null,

    /// The expiration timestamp of the environment credentials.
    expiration: ?i64 = null,

    /// The secret access key of the environment credentials.
    secret_access_key: ?[]const u8 = null,

    /// The session token of the environment credentials.
    session_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .expiration = "expiration",
        .secret_access_key = "secretAccessKey",
        .session_token = "sessionToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEnvironmentCredentialsInput, options: CallOptions) !GetEnvironmentCredentialsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEnvironmentCredentialsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_identifier);
    try path_buf.appendSlice(allocator, "/credentials");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEnvironmentCredentialsOutput {
    const result: GetEnvironmentCredentialsOutput = try aws.json.parseJsonObject(
        GetEnvironmentCredentialsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
