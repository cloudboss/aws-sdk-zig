const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourcePermission = @import("resource_permission.zig").ResourcePermission;

pub const UpdateKnowledgeBasePermissionsInput = struct {
    /// The ID of the Amazon Web Services account that contains the knowledge base.
    aws_account_id: []const u8,

    /// The resource permissions that you want to grant on the knowledge base.
    grant_permissions: ?[]const ResourcePermission = null,

    /// The unique identifier for the knowledge base.
    knowledge_base_id: []const u8,

    /// The resource permissions that you want to revoke from the knowledge base.
    revoke_permissions: ?[]const ResourcePermission = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .grant_permissions = "GrantPermissions",
        .knowledge_base_id = "KnowledgeBaseId",
        .revoke_permissions = "RevokePermissions",
    };
};

pub const UpdateKnowledgeBasePermissionsOutput = struct {
    /// The Amazon Resource Name (ARN) of the knowledge base.
    knowledge_base_arn: []const u8,

    /// The unique identifier for the knowledge base.
    knowledge_base_id: []const u8,

    /// The resource permissions for the knowledge base.
    permissions: ?[]const ResourcePermission = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .knowledge_base_arn = "KnowledgeBaseArn",
        .knowledge_base_id = "KnowledgeBaseId",
        .permissions = "Permissions",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateKnowledgeBasePermissionsInput, options: CallOptions) !UpdateKnowledgeBasePermissionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateKnowledgeBasePermissionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/knowledge-bases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/permissions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.grant_permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GrantPermissions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.revoke_permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RevokePermissions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateKnowledgeBasePermissionsOutput {
    var result: UpdateKnowledgeBasePermissionsOutput = try aws.json.parseJsonObject(
        UpdateKnowledgeBasePermissionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
