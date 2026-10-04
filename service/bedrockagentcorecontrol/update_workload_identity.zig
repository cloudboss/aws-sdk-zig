const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateWorkloadIdentityInput = struct {
    /// The new list of allowed OAuth2 return URLs for resources associated with
    /// this workload identity. This list replaces the existing list.
    allowed_resource_oauth_2_return_urls: ?[]const []const u8 = null,

    /// The name of the workload identity to update.
    name: []const u8,

    pub const json_field_names = .{
        .allowed_resource_oauth_2_return_urls = "allowedResourceOauth2ReturnUrls",
        .name = "name",
    };
};

pub const UpdateWorkloadIdentityOutput = struct {
    /// The list of allowed OAuth2 return URLs for resources associated with this
    /// workload identity.
    allowed_resource_oauth_2_return_urls: ?[]const []const u8 = null,

    /// The timestamp when the workload identity was created.
    created_time: i64,

    /// The timestamp when the workload identity was last updated.
    last_updated_time: i64,

    /// The name of the workload identity.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the workload identity.
    workload_identity_arn: []const u8,

    pub const json_field_names = .{
        .allowed_resource_oauth_2_return_urls = "allowedResourceOauth2ReturnUrls",
        .created_time = "createdTime",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
        .workload_identity_arn = "workloadIdentityArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkloadIdentityInput, options: CallOptions) !UpdateWorkloadIdentityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkloadIdentityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/identities/UpdateWorkloadIdentity";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allowed_resource_oauth_2_return_urls) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"allowedResourceOauth2ReturnUrls\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkloadIdentityOutput {
    const result: UpdateWorkloadIdentityOutput = try aws.json.parseJsonObject(
        UpdateWorkloadIdentityOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
