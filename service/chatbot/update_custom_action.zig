const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomActionAttachment = @import("custom_action_attachment.zig").CustomActionAttachment;
const CustomActionDefinition = @import("custom_action_definition.zig").CustomActionDefinition;

pub const UpdateCustomActionInput = struct {
    /// The name used to invoke this action in the chat channel. For example, `@aws
    /// run my-alias`.
    alias_name: ?[]const u8 = null,

    /// Defines when this custom action button should be attached to a notification.
    attachments: ?[]const CustomActionAttachment = null,

    /// The fully defined Amazon Resource Name (ARN) of the custom action.
    custom_action_arn: []const u8,

    /// The definition of the command to run when invoked as an alias or as an
    /// action button.
    definition: CustomActionDefinition,

    pub const json_field_names = .{
        .alias_name = "AliasName",
        .attachments = "Attachments",
        .custom_action_arn = "CustomActionArn",
        .definition = "Definition",
    };
};

pub const UpdateCustomActionOutput = struct {
    /// The fully defined ARN of the custom action.
    custom_action_arn: []const u8,

    pub const json_field_names = .{
        .custom_action_arn = "CustomActionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCustomActionInput, options: CallOptions) !UpdateCustomActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chatbot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCustomActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chatbot", "chatbot", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/update-custom-action";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.alias_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AliasName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.attachments) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Attachments\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CustomActionArn\":");
    try aws.json.writeValue(@TypeOf(input.custom_action_arn), input.custom_action_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Definition\":");
    try aws.json.writeValue(@TypeOf(input.definition), input.definition, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCustomActionOutput {
    var result: UpdateCustomActionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateCustomActionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
