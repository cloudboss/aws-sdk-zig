const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CellInformation = @import("cell_information.zig").CellInformation;
const EnvironmentConfig = @import("environment_config.zig").EnvironmentConfig;
const NotebookStatus = @import("notebook_status.zig").NotebookStatus;
const NotebookType = @import("notebook_type.zig").NotebookType;
const NotebookError = @import("notebook_error.zig").NotebookError;
const GitMetadata = @import("git_metadata.zig").GitMetadata;

pub const UpdateNotebookInput = struct {
    /// The updated ordered list of cells in the notebook.
    cell_order: ?[]const CellInformation = null,

    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    /// This field is automatically populated if not provided.
    client_token: ?[]const u8 = null,

    /// The updated description of the notebook.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon SageMaker Unified Studio domain in which the
    /// notebook exists.
    domain_identifier: []const u8,

    /// The updated environment configuration for the notebook.
    environment_configuration: ?EnvironmentConfig = null,

    /// The identifier of the notebook to update.
    identifier: []const u8,

    /// The updated metadata for the notebook, specified as key-value pairs.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The updated name of the notebook.
    name: ?[]const u8 = null,

    /// The updated sensitive parameters for the notebook, specified as key-value
    /// pairs.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The updated status of the notebook.
    status: ?NotebookStatus = null,

    /// The updated type of the notebook.
    type: ?NotebookType = null,

    pub const json_field_names = .{
        .cell_order = "cellOrder",
        .client_token = "clientToken",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .environment_configuration = "environmentConfiguration",
        .identifier = "identifier",
        .metadata = "metadata",
        .name = "name",
        .parameters = "parameters",
        .status = "status",
        .type = "type",
    };
};

pub const UpdateNotebookOutput = struct {
    /// The ordered list of cells in the notebook.
    cell_order: ?[]const CellInformation = null,

    /// The identifier of the compute associated with the notebook.
    compute_id: ?[]const u8 = null,

    /// The timestamp of when the notebook was created.
    created_at: ?i64 = null,

    /// The identifier of the user who created the notebook.
    created_by: ?[]const u8 = null,

    /// The description of the notebook.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon SageMaker Unified Studio domain.
    domain_id: []const u8,

    /// The environment configuration of the notebook.
    environment_configuration: ?EnvironmentConfig = null,

    /// The error details if the notebook is in a failed state.
    @"error": ?NotebookError = null,

    /// The Git metadata associated with the notebook.
    git_metadata: ?GitMetadata = null,

    /// The identifier of the notebook.
    id: []const u8,

    /// The timestamp of when the notebook was locked.
    locked_at: ?i64 = null,

    /// The identifier of the user who locked the notebook.
    locked_by: ?[]const u8 = null,

    /// The timestamp of when the notebook lock expires.
    lock_expires_at: ?i64 = null,

    /// The metadata of the notebook.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The name of the notebook.
    name: []const u8,

    /// The identifier of the project that owns the notebook.
    owning_project_id: []const u8,

    /// The sensitive parameters of the notebook.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The status of the notebook.
    status: NotebookStatus,

    /// The type of the notebook.
    type: ?NotebookType = null,

    /// The timestamp of when the notebook was last updated.
    updated_at: ?i64 = null,

    /// The identifier of the user who last updated the notebook.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .cell_order = "cellOrder",
        .compute_id = "computeId",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .environment_configuration = "environmentConfiguration",
        .@"error" = "error",
        .git_metadata = "gitMetadata",
        .id = "id",
        .locked_at = "lockedAt",
        .locked_by = "lockedBy",
        .lock_expires_at = "lockExpiresAt",
        .metadata = "metadata",
        .name = "name",
        .owning_project_id = "owningProjectId",
        .parameters = "parameters",
        .status = "status",
        .type = "type",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateNotebookInput, options: CallOptions) !UpdateNotebookOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateNotebookInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/notebooks/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.cell_order) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cellOrder\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"status\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"type\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateNotebookOutput {
    const result: UpdateNotebookOutput = try aws.json.parseJsonObject(
        UpdateNotebookOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
