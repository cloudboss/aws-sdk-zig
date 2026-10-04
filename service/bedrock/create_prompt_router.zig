const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PromptRouterTargetModel = @import("prompt_router_target_model.zig").PromptRouterTargetModel;
const RoutingCriteria = @import("routing_criteria.zig").RoutingCriteria;
const Tag = @import("tag.zig").Tag;

pub const CreatePromptRouterInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure idempotency
    /// of your requests. If not specified, the Amazon Web Services SDK
    /// automatically generates one for you.
    client_request_token: ?[]const u8 = null,

    /// An optional description of the prompt router to help identify its purpose.
    description: ?[]const u8 = null,

    /// The default model to use when the routing criteria is not met.
    fallback_model: PromptRouterTargetModel,

    /// A list of foundation models that the prompt router can route requests to. At
    /// least one model must be specified.
    models: []const PromptRouterTargetModel,

    /// The name of the prompt router. The name must be unique within your Amazon
    /// Web Services account in the current region.
    prompt_router_name: []const u8,

    /// The criteria, which is the response quality difference, used to determine
    /// how incoming requests are routed to different models.
    routing_criteria: RoutingCriteria,

    /// An array of key-value pairs to apply to this resource as tags. You can use
    /// tags to categorize and manage your Amazon Web Services resources.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .description = "description",
        .fallback_model = "fallbackModel",
        .models = "models",
        .prompt_router_name = "promptRouterName",
        .routing_criteria = "routingCriteria",
        .tags = "tags",
    };
};

pub const CreatePromptRouterOutput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the prompt router.
    prompt_router_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .prompt_router_arn = "promptRouterArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePromptRouterInput, options: CallOptions) !CreatePromptRouterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePromptRouterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/prompt-routers";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"fallbackModel\":");
    try aws.json.writeValue(@TypeOf(input.fallback_model), input.fallback_model, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"models\":");
    try aws.json.writeValue(@TypeOf(input.models), input.models, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"promptRouterName\":");
    try aws.json.writeValue(@TypeOf(input.prompt_router_name), input.prompt_router_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"routingCriteria\":");
    try aws.json.writeValue(@TypeOf(input.routing_criteria), input.routing_criteria, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePromptRouterOutput {
    var result: CreatePromptRouterOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePromptRouterOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
