const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PromptRouterTargetModel = @import("prompt_router_target_model.zig").PromptRouterTargetModel;
const RoutingCriteria = @import("routing_criteria.zig").RoutingCriteria;
const PromptRouterStatus = @import("prompt_router_status.zig").PromptRouterStatus;
const PromptRouterType = @import("prompt_router_type.zig").PromptRouterType;

pub const GetPromptRouterInput = struct {
    /// The prompt router's ARN
    prompt_router_arn: []const u8,

    pub const json_field_names = .{
        .prompt_router_arn = "promptRouterArn",
    };
};

pub const GetPromptRouterOutput = struct {
    /// When the router was created.
    created_at: ?i64 = null,

    /// The router's description.
    description: ?[]const u8 = null,

    /// The router's fallback model.
    fallback_model: ?PromptRouterTargetModel = null,

    /// The router's models.
    models: ?[]const PromptRouterTargetModel = null,

    /// The prompt router's ARN
    prompt_router_arn: []const u8,

    /// The router's name.
    prompt_router_name: []const u8,

    /// The router's routing criteria.
    routing_criteria: ?RoutingCriteria = null,

    /// The router's status.
    status: PromptRouterStatus,

    /// The router's type.
    type: PromptRouterType,

    /// When the router was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .fallback_model = "fallbackModel",
        .models = "models",
        .prompt_router_arn = "promptRouterArn",
        .prompt_router_name = "promptRouterName",
        .routing_criteria = "routingCriteria",
        .status = "status",
        .type = "type",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPromptRouterInput, options: CallOptions) !GetPromptRouterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPromptRouterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prompt-routers/");
    try path_buf.appendSlice(allocator, input.prompt_router_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPromptRouterOutput {
    const result: GetPromptRouterOutput = try aws.json.parseJsonObject(
        GetPromptRouterOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
