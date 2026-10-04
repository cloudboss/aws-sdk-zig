const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AddLayerVersionPermissionInput = struct {
    /// The API action that grants access to the layer. For example,
    /// `lambda:GetLayerVersion`.
    action: []const u8,

    /// The name or Amazon Resource Name (ARN) of the layer.
    layer_name: []const u8,

    /// With the principal set to `*`, grant permission to all accounts in the
    /// specified organization.
    organization_id: ?[]const u8 = null,

    /// An account ID, or `*` to grant layer usage permission to all accounts in an
    /// organization, or all Amazon Web Services accounts (if `organizationId` is
    /// not specified). For the last case, make sure that you really do want all
    /// Amazon Web Services accounts to have usage permission to this layer.
    principal: []const u8,

    /// Only update the policy if the revision ID matches the ID specified. Use this
    /// option to avoid modifying a policy that has changed since you last read it.
    revision_id: ?[]const u8 = null,

    /// An identifier that distinguishes the policy from others on the same layer
    /// version.
    statement_id: []const u8,

    /// The version number.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .action = "Action",
        .layer_name = "LayerName",
        .organization_id = "OrganizationId",
        .principal = "Principal",
        .revision_id = "RevisionId",
        .statement_id = "StatementId",
        .version_number = "VersionNumber",
    };
};

pub const AddLayerVersionPermissionOutput = struct {
    /// A unique identifier for the current revision of the policy.
    revision_id: ?[]const u8 = null,

    /// The permission statement.
    statement: ?[]const u8 = null,

    pub const json_field_names = .{
        .revision_id = "RevisionId",
        .statement = "Statement",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddLayerVersionPermissionInput, options: CallOptions) !AddLayerVersionPermissionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddLayerVersionPermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2018-10-31/layers/");
    try path_buf.appendSlice(allocator, input.layer_name);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.version_number);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.revision_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "RevisionId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (input.organization_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OrganizationId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Principal\":");
    try aws.json.writeValue(@TypeOf(input.principal), input.principal, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StatementId\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddLayerVersionPermissionOutput {
    var result: AddLayerVersionPermissionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(AddLayerVersionPermissionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
