const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GitMetadata = @import("git_metadata.zig").GitMetadata;
const SourceLocation = @import("source_location.zig").SourceLocation;
const NotebookStatus = @import("notebook_status.zig").NotebookStatus;

pub const StartNotebookSyncInput = struct {
    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    /// This field is automatically populated if not provided.
    client_token: ?[]const u8 = null,

    /// The description of the notebook.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon SageMaker Unified Studio domain in which to
    /// sync the notebook.
    domain_identifier: []const u8,

    /// The Git metadata for the notebook sync, including repository, branch, and
    /// commit information.
    git_metadata: ?GitMetadata = null,

    /// The name of the notebook. The name must be between 1 and 256 characters.
    name: ?[]const u8 = null,

    /// The identifier of an existing notebook to sync. If not specified, a new
    /// notebook is created.
    notebook_id: ?[]const u8 = null,

    /// The identifier of the project that will own the synced notebook.
    owning_project_identifier: []const u8,

    /// The source location of the notebook to sync. This specifies the Amazon
    /// Simple Storage Service URI of the notebook file.
    source_location: SourceLocation,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .domain_identifier = "domainIdentifier",
        .git_metadata = "gitMetadata",
        .name = "name",
        .notebook_id = "notebookId",
        .owning_project_identifier = "owningProjectIdentifier",
        .source_location = "sourceLocation",
    };
};

pub const StartNotebookSyncOutput = struct {
    /// The timestamp of when the notebook sync was started.
    created_at: ?i64 = null,

    /// The identifier of the user who started the notebook sync.
    created_by: ?[]const u8 = null,

    /// The description of the synced notebook.
    description: ?[]const u8 = null,

    /// The identifier of the Amazon SageMaker Unified Studio domain.
    domain_id: ?[]const u8 = null,

    /// The Git metadata associated with the synced notebook.
    git_metadata: ?GitMetadata = null,

    /// The name of the synced notebook.
    name: ?[]const u8 = null,

    /// The identifier of the synced notebook.
    notebook_id: ?[]const u8 = null,

    /// The identifier of the project that owns the synced notebook.
    owning_project_id: ?[]const u8 = null,

    /// The source location from which the notebook was synced.
    source_location: ?SourceLocation = null,

    /// The status of the notebook sync.
    status: ?NotebookStatus = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .domain_id = "domainId",
        .git_metadata = "gitMetadata",
        .name = "name",
        .notebook_id = "notebookId",
        .owning_project_id = "owningProjectId",
        .source_location = "sourceLocation",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartNotebookSyncInput, options: CallOptions) !StartNotebookSyncOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartNotebookSyncInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/notebook-syncs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.git_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"gitMetadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.notebook_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"notebookId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"owningProjectIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.owning_project_identifier), input.owning_project_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceLocation\":");
    try aws.json.writeValue(@TypeOf(input.source_location), input.source_location, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartNotebookSyncOutput {
    const result: StartNotebookSyncOutput = try aws.json.parseJsonObject(
        StartNotebookSyncOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
