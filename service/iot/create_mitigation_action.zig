const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MitigationActionParams = @import("mitigation_action_params.zig").MitigationActionParams;
const Tag = @import("tag.zig").Tag;

pub const CreateMitigationActionInput = struct {
    /// A friendly name for the action. Choose a friendly name that accurately
    /// describes the action (for example, `EnableLoggingAction`).
    action_name: []const u8,

    /// Defines the type of action and the parameters for that action.
    action_params: MitigationActionParams,

    /// The ARN of the IAM role that is used to apply the mitigation action.
    role_arn: []const u8,

    /// Metadata that can be used to manage the mitigation action.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .action_name = "actionName",
        .action_params = "actionParams",
        .role_arn = "roleArn",
        .tags = "tags",
    };
};

pub const CreateMitigationActionOutput = struct {
    /// The ARN for the new mitigation action.
    action_arn: ?[]const u8 = null,

    /// A unique identifier for the new mitigation action.
    action_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_arn = "actionArn",
        .action_id = "actionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMitigationActionInput, options: CallOptions) !CreateMitigationActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMitigationActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/mitigationactions/actions/");
    try path_buf.appendSlice(allocator, input.action_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"actionParams\":");
    try aws.json.writeValue(@TypeOf(input.action_params), input.action_params, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMitigationActionOutput {
    var result: CreateMitigationActionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateMitigationActionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
