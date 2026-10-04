const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GatewayRuleStatus = @import("gateway_rule_status.zig").GatewayRuleStatus;

pub const DeleteGatewayRuleInput = struct {
    /// The identifier of the gateway containing the rule.
    gateway_identifier: []const u8,

    /// The unique identifier of the rule to delete.
    rule_id: []const u8,

    pub const json_field_names = .{
        .gateway_identifier = "gatewayIdentifier",
        .rule_id = "ruleId",
    };
};

pub const DeleteGatewayRuleOutput = struct {
    /// The unique identifier of the deleted rule.
    rule_id: []const u8,

    /// The status of the rule deletion operation.
    status: GatewayRuleStatus,

    pub const json_field_names = .{
        .rule_id = "ruleId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteGatewayRuleInput, options: CallOptions) !DeleteGatewayRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteGatewayRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_identifier);
    try path_buf.appendSlice(allocator, "/rules/");
    try path_buf.appendSlice(allocator, input.rule_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteGatewayRuleOutput {
    var result: DeleteGatewayRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteGatewayRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
