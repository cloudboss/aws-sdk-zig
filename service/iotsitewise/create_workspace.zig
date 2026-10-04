const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkspaceEncryptionConfiguration = @import("workspace_encryption_configuration.zig").WorkspaceEncryptionConfiguration;
const WorkspaceStatus = @import("workspace_status.zig").WorkspaceStatus;

pub const CreateWorkspaceInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure that the
    /// request is
    /// idempotent. If you retry a request that completed successfully using the
    /// same client token,
    /// the retry succeeds without performing any further actions.
    client_token: ?[]const u8 = null,

    /// The encryption configuration for the workspace.
    encryption_configuration: WorkspaceEncryptionConfiguration,

    /// A list of key-value pairs that contain metadata for the workspace. For more
    /// information,
    /// see [Tagging your IoT SiteWise
    /// resources](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/tag-resources.html) in the *IoT SiteWise User Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A description for the workspace.
    workspace_description: ?[]const u8 = null,

    /// The name of the workspace to create.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .encryption_configuration = "encryptionConfiguration",
        .tags = "tags",
        .workspace_description = "workspaceDescription",
        .workspace_name = "workspaceName",
    };
};

pub const CreateWorkspaceOutput = struct {
    /// The ARN of the workspace.
    workspace_arn: []const u8,

    /// The name of the workspace.
    workspace_name: []const u8,

    /// The status of the workspace, which is `CREATING` when the operation
    /// returns.
    workspace_status: ?WorkspaceStatus = null,

    pub const json_field_names = .{
        .workspace_arn = "workspaceArn",
        .workspace_name = "workspaceName",
        .workspace_status = "workspaceStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkspaceInput, options: CallOptions) !CreateWorkspaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkspaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/workspaces";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"encryptionConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.encryption_configuration), input.encryption_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.workspace_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workspaceDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"workspaceName\":");
    try aws.json.writeValue(@TypeOf(input.workspace_name), input.workspace_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkspaceOutput {
    const result: CreateWorkspaceOutput = try aws.json.parseJsonObject(
        CreateWorkspaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
