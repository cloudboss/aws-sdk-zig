const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetaFlowCategory = @import("meta_flow_category.zig").MetaFlowCategory;

pub const CreateWhatsAppFlowInput = struct {
    /// The categories that classify the business purpose of the Flow. At least one
    /// category is required.
    categories: []const MetaFlowCategory,

    /// The ID of an existing Flow within the same WhatsApp Business Account to
    /// clone.
    clone_flow_id: ?[]const u8 = null,

    /// The HTTPS endpoint that Meta calls for a data exchange Flow.
    endpoint_uri: ?[]const u8 = null,

    /// The Flow JSON definition that describes the screens, components, and logic
    /// of the Flow. Maximum size is 10 MB.
    flow_json: ?[]const u8 = null,

    /// The name of the Flow. Must be unique within the WhatsApp Business Account.
    flow_name: []const u8,

    /// The ID of the WhatsApp Business Account to associate with this Flow.
    id: []const u8,

    /// Set to `true` to publish the Flow immediately after creation. Requires a
    /// valid `flowJson` that passes Meta's validation.
    publish: ?bool = null,

    pub const json_field_names = .{
        .categories = "categories",
        .clone_flow_id = "cloneFlowId",
        .endpoint_uri = "endpointUri",
        .flow_json = "flowJson",
        .flow_name = "flowName",
        .id = "id",
        .publish = "publish",
    };
};

pub const CreateWhatsAppFlowOutput = struct {
    /// The unique identifier assigned to the Flow by Meta.
    flow_id: ?[]const u8 = null,

    /// A list of validation errors returned by Meta, if any. Validation errors must
    /// be resolved before the Flow can be published.
    validation_errors: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .flow_id = "flowId",
        .validation_errors = "validationErrors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWhatsAppFlowInput, options: CallOptions) !CreateWhatsAppFlowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "social-messaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWhatsAppFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/flow/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"categories\":");
    try aws.json.writeValue(@TypeOf(input.categories), input.categories, allocator, &body_buf);
    has_prev = true;
    if (input.clone_flow_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cloneFlowId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.endpoint_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"endpointUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.flow_json) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"flowJson\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"flowName\":");
    try aws.json.writeValue(@TypeOf(input.flow_name), input.flow_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"id\":");
    try aws.json.writeValue(@TypeOf(input.id), input.id, allocator, &body_buf);
    has_prev = true;
    if (input.publish) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"publish\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWhatsAppFlowOutput {
    const result: CreateWhatsAppFlowOutput = try aws.json.parseJsonObject(
        CreateWhatsAppFlowOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
