const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdentityProviderConfig = @import("identity_provider_config.zig").IdentityProviderConfig;
const IdentityProviderConfigResponse = @import("identity_provider_config_response.zig").IdentityProviderConfigResponse;

pub const DescribeIdentityProviderConfigInput = struct {
    /// The name of your cluster.
    cluster_name: []const u8,

    /// An object representing an identity provider configuration.
    identity_provider_config: IdentityProviderConfig,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
        .identity_provider_config = "identityProviderConfig",
    };
};

pub const DescribeIdentityProviderConfigOutput = struct {
    /// The object that represents an OpenID Connect (OIDC) identity provider
    /// configuration.
    identity_provider_config: ?IdentityProviderConfigResponse = null,

    pub const json_field_names = .{
        .identity_provider_config = "identityProviderConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeIdentityProviderConfigInput, options: CallOptions) !DescribeIdentityProviderConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "eks", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeIdentityProviderConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    try path_buf.appendSlice(allocator, "/identity-provider-configs/describe");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"identityProviderConfig\":");
    try aws.json.writeValue(@TypeOf(input.identity_provider_config), input.identity_provider_config, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeIdentityProviderConfigOutput {
    var result: DescribeIdentityProviderConfigOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeIdentityProviderConfigOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
