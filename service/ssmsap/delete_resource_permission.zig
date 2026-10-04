const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PermissionActionType = @import("permission_action_type.zig").PermissionActionType;

pub const DeleteResourcePermissionInput = struct {
    /// Delete or restore the permissions on the target database.
    action_type: ?PermissionActionType = null,

    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the source resource.
    source_resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_type = "ActionType",
        .resource_arn = "ResourceArn",
        .source_resource_arn = "SourceResourceArn",
    };
};

pub const DeleteResourcePermissionOutput = struct {
    /// The policy that removes permissions on the target database.
    policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "Policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteResourcePermissionInput, options: CallOptions) !DeleteResourcePermissionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-sap", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteResourcePermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm-sap", "Ssm Sap", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/delete-resource-permission";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.action_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ActionType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_arn), input.resource_arn, allocator, &body_buf);
    has_prev = true;
    if (input.source_resource_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SourceResourceArn\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteResourcePermissionOutput {
    const result: DeleteResourcePermissionOutput = try aws.json.parseJsonObject(
        DeleteResourcePermissionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
