const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const AuthorizerType = @import("authorizer_type.zig").AuthorizerType;
const ExceptionLevel = @import("exception_level.zig").ExceptionLevel;
const GatewayInterceptorConfiguration = @import("gateway_interceptor_configuration.zig").GatewayInterceptorConfiguration;
const GatewayPolicyEngineConfiguration = @import("gateway_policy_engine_configuration.zig").GatewayPolicyEngineConfiguration;
const GatewayProtocolConfiguration = @import("gateway_protocol_configuration.zig").GatewayProtocolConfiguration;
const GatewayProtocolType = @import("gateway_protocol_type.zig").GatewayProtocolType;
const GatewayStatus = @import("gateway_status.zig").GatewayStatus;
const WorkloadIdentityDetails = @import("workload_identity_details.zig").WorkloadIdentityDetails;

pub const GetGatewayInput = @import("get_gateway_request.zig").GetGatewayRequest;

pub const GetGatewayOutput = @import("get_gateway_response.zig").GetGatewayResponse;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGatewayInput, options: CallOptions) !GetGatewayOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_identifier);
    try path_buf.appendSlice(allocator, "/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGatewayOutput {
    var result: GetGatewayOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetGatewayOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
