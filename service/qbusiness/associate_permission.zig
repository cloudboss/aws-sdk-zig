const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PermissionCondition = @import("permission_condition.zig").PermissionCondition;

pub const AssociatePermissionInput = struct {
    /// The list of Amazon Q Business actions that the ISV is allowed to perform.
    actions: []const []const u8,

    /// The unique identifier of the Amazon Q Business application.
    application_id: []const u8,

    /// The conditions that restrict when the permission is effective. These
    /// conditions can be used to limit the permission based on specific attributes
    /// of the request.
    conditions: ?[]const PermissionCondition = null,

    /// The Amazon Resource Name of the IAM role for the ISV that is being granted
    /// permission.
    principal: []const u8,

    /// A unique identifier for the policy statement.
    statement_id: []const u8,

    pub const json_field_names = .{
        .actions = "actions",
        .application_id = "applicationId",
        .conditions = "conditions",
        .principal = "principal",
        .statement_id = "statementId",
    };
};

pub const AssociatePermissionOutput = struct {
    /// The JSON representation of the added permission statement.
    statement: ?[]const u8 = null,

    pub const json_field_names = .{
        .statement = "statement",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociatePermissionInput, options: CallOptions) !AssociatePermissionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociatePermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"actions\":");
    try aws.json.writeValue(@TypeOf(input.actions), input.actions, allocator, &body_buf);
    has_prev = true;
    if (input.conditions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"conditions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"principal\":");
    try aws.json.writeValue(@TypeOf(input.principal), input.principal, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"statementId\":");
    try aws.json.writeValue(@TypeOf(input.statement_id), input.statement_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociatePermissionOutput {
    var result: AssociatePermissionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AssociatePermissionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
