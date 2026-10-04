const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HttpEndpoint = @import("http_endpoint.zig").HttpEndpoint;
const HttpProtocolIpv6 = @import("http_protocol_ipv_6.zig").HttpProtocolIpv6;
const HttpTokens = @import("http_tokens.zig").HttpTokens;
const Operation = @import("operation.zig").Operation;

pub const UpdateInstanceMetadataOptionsInput = struct {
    /// Enables or disables the HTTP metadata endpoint on your instances. If this
    /// parameter is not
    /// specified, the existing state is maintained.
    ///
    /// If you specify a value of `disabled`, you cannot access your instance
    /// metadata.
    http_endpoint: ?HttpEndpoint = null,

    /// Enables or disables the IPv6 endpoint for the instance metadata service.
    /// This setting
    /// applies only when the HTTP metadata endpoint is enabled.
    ///
    /// This parameter is available only for instances in the Europe (Stockholm)
    /// Amazon Web Services Region (`eu-north-1`).
    http_protocol_ipv_6: ?HttpProtocolIpv6 = null,

    /// The desired HTTP PUT response hop limit for instance metadata requests. A
    /// larger number
    /// means that the instance metadata requests can travel farther. If no
    /// parameter is specified,
    /// the existing state is maintained.
    http_put_response_hop_limit: ?i32 = null,

    /// The state of token usage for your instance metadata requests. If the
    /// parameter is not
    /// specified in the request, the default state is `optional`.
    ///
    /// If the state is `optional`, you can choose whether to retrieve instance
    /// metadata with a signed token header on your request. If you retrieve the IAM
    /// role credentials
    /// without a token, the version 1.0 role credentials are returned. If you
    /// retrieve the IAM role
    /// credentials by using a valid signed token, the version 2.0 role credentials
    /// are
    /// returned.
    ///
    /// If the state is `required`, you must send a signed token header with all
    /// instance metadata retrieval requests. In this state, retrieving the IAM role
    /// credential always
    /// returns the version 2.0 credentials. The version 1.0 credentials are not
    /// available.
    http_tokens: ?HttpTokens = null,

    /// The name of the instance for which to update metadata parameters.
    instance_name: []const u8,

    pub const json_field_names = .{
        .http_endpoint = "httpEndpoint",
        .http_protocol_ipv_6 = "httpProtocolIpv6",
        .http_put_response_hop_limit = "httpPutResponseHopLimit",
        .http_tokens = "httpTokens",
        .instance_name = "instanceName",
    };
};

pub const UpdateInstanceMetadataOptionsOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operation: ?Operation = null,

    pub const json_field_names = .{
        .operation = "operation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateInstanceMetadataOptionsInput, options: CallOptions) !UpdateInstanceMetadataOptionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateInstanceMetadataOptionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.UpdateInstanceMetadataOptions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateInstanceMetadataOptionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateInstanceMetadataOptionsOutput, body, allocator);
}
