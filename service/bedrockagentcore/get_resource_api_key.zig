const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetResourceApiKeyInput = struct {
    /// The credential provider name for the resource from which you are retrieving
    /// the API key.
    resource_credential_provider_name: []const u8,

    /// The identity token of the workload from which you want to retrieve the API
    /// key.
    workload_identity_token: []const u8,

    pub const json_field_names = .{
        .resource_credential_provider_name = "resourceCredentialProviderName",
        .workload_identity_token = "workloadIdentityToken",
    };
};

pub const GetResourceApiKeyOutput = struct {
    /// The API key associated with the resource requested.
    api_key: []const u8,

    pub const json_field_names = .{
        .api_key = "apiKey",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceApiKeyInput, options: CallOptions) !GetResourceApiKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceApiKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/identities/api-key";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceCredentialProviderName\":");
    try aws.json.writeValue(@TypeOf(input.resource_credential_provider_name), input.resource_credential_provider_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"workloadIdentityToken\":");
    try aws.json.writeValue(@TypeOf(input.workload_identity_token), input.workload_identity_token, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceApiKeyOutput {
    var result: GetResourceApiKeyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetResourceApiKeyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
