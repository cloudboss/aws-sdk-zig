const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppDefinitionInput = @import("app_definition_input.zig").AppDefinitionInput;
const AppRequiredCapability = @import("app_required_capability.zig").AppRequiredCapability;
const AppStatus = @import("app_status.zig").AppStatus;

pub const UpdateQAppInput = struct {
    /// The new definition specifying the cards and flow for the Q App.
    app_definition: ?AppDefinitionInput = null,

    /// The unique identifier of the Q App to update.
    app_id: []const u8,

    /// The new description for the Q App.
    description: ?[]const u8 = null,

    /// The unique identifier of the Amazon Q Business application environment
    /// instance.
    instance_id: []const u8,

    /// The new title for the Q App.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_definition = "appDefinition",
        .app_id = "appId",
        .description = "description",
        .instance_id = "instanceId",
        .title = "title",
    };
};

pub const UpdateQAppOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated Q App.
    app_arn: []const u8,

    /// The unique identifier of the updated Q App.
    app_id: []const u8,

    /// The new version of the updated Q App.
    app_version: i32,

    /// The date and time the Q App was originally created.
    created_at: i64,

    /// The user who originally created the Q App.
    created_by: []const u8,

    /// The new description of the updated Q App.
    description: ?[]const u8 = null,

    /// The initial prompt for the updated Q App.
    initial_prompt: ?[]const u8 = null,

    /// The capabilities required for the updated Q App.
    required_capabilities: ?[]const AppRequiredCapability = null,

    /// The status of the updated Q App.
    status: AppStatus,

    /// The new title of the updated Q App.
    title: []const u8,

    /// The date and time the Q App was last updated.
    updated_at: i64,

    /// The user who last updated the Q App.
    updated_by: []const u8,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .app_id = "appId",
        .app_version = "appVersion",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .initial_prompt = "initialPrompt",
        .required_capabilities = "requiredCapabilities",
        .status = "status",
        .title = "title",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateQAppInput, options: CallOptions) !UpdateQAppOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qapps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateQAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.qapps", "QApps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/apps.update";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.app_definition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"appDefinition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appId\":");
    try aws.json.writeValue(@TypeOf(input.app_id), input.app_id, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.title) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"title\":");
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
    try request.headers.put(allocator, "instance-id", input.instance_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateQAppOutput {
    const result: UpdateQAppOutput = try aws.json.parseJsonObject(
        UpdateQAppOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
