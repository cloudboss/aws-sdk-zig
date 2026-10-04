const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecipeStep = @import("recipe_step.zig").RecipeStep;
const ViewFrame = @import("view_frame.zig").ViewFrame;

pub const SendProjectSessionActionInput = struct {
    /// A unique identifier for an interactive session that's currently open and
    /// ready for
    /// work. The action will be performed on this session.
    client_session_id: ?[]const u8 = null,

    /// The name of the project to apply the action to.
    name: []const u8,

    /// If true, the result of the recipe step will be returned, but not applied.
    preview: ?bool = null,

    recipe_step: ?RecipeStep = null,

    /// The index from which to preview a step. This index is used to preview the
    /// result of
    /// steps that have already been applied, so that the resulting view frame is
    /// from earlier
    /// in the view frame stack.
    step_index: ?i32 = null,

    view_frame: ?ViewFrame = null,

    pub const json_field_names = .{
        .client_session_id = "ClientSessionId",
        .name = "Name",
        .preview = "Preview",
        .recipe_step = "RecipeStep",
        .step_index = "StepIndex",
        .view_frame = "ViewFrame",
    };
};

pub const SendProjectSessionActionOutput = struct {
    /// A unique identifier for the action that was performed.
    action_id: ?i32 = null,

    /// The name of the project that was affected by the action.
    name: []const u8,

    /// A message indicating the result of performing the action.
    result: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_id = "ActionId",
        .name = "Name",
        .result = "Result",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendProjectSessionActionInput, options: CallOptions) !SendProjectSessionActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "databrew", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendProjectSessionActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databrew", "DataBrew", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/sendProjectSessionAction");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_session_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientSessionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.preview) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Preview\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.recipe_step) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RecipeStep\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.step_index) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StepIndex\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.view_frame) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ViewFrame\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendProjectSessionActionOutput {
    var result: SendProjectSessionActionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SendProjectSessionActionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
