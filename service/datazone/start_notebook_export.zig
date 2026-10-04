const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileFormat = @import("file_format.zig").FileFormat;
const NotebookExportStatus = @import("notebook_export_status.zig").NotebookExportStatus;

pub const StartNotebookExportInput = struct {
    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    /// This field is automatically populated if not provided.
    client_token: ?[]const u8 = null,

    /// The identifier of the Amazon SageMaker Unified Studio domain in which to
    /// export the notebook.
    domain_identifier: []const u8,

    /// The file format for the notebook export. Valid values are `PDF` and `IPYNB`.
    file_format: FileFormat,

    /// The identifier of the notebook to export.
    notebook_identifier: []const u8,

    /// The identifier of the project that owns the notebook.
    owning_project_identifier: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .domain_identifier = "domainIdentifier",
        .file_format = "fileFormat",
        .notebook_identifier = "notebookIdentifier",
        .owning_project_identifier = "owningProjectIdentifier",
    };
};

pub const StartNotebookExportOutput = struct {
    /// The timestamp of when the notebook export was started.
    created_at: ?i64 = null,

    /// The identifier of the user who started the notebook export.
    created_by: ?[]const u8 = null,

    /// The identifier of the Amazon SageMaker Unified Studio domain.
    domain_id: []const u8,

    /// The file format of the notebook export.
    file_format: FileFormat,

    /// The identifier of the notebook export.
    id: []const u8,

    /// The identifier of the notebook.
    notebook_id: []const u8,

    /// The identifier of the project that owns the notebook.
    owning_project_id: []const u8,

    /// The status of the notebook export.
    status: NotebookExportStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .file_format = "fileFormat",
        .id = "id",
        .notebook_id = "notebookId",
        .owning_project_id = "owningProjectId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartNotebookExportInput, options: CallOptions) !StartNotebookExportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartNotebookExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/notebook-exports");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"fileFormat\":");
    try aws.json.writeValue(@TypeOf(input.file_format), input.file_format, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"notebookIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.notebook_identifier), input.notebook_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"owningProjectIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.owning_project_identifier), input.owning_project_identifier, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartNotebookExportOutput {
    const result: StartNotebookExportOutput = try aws.json.parseJsonObject(
        StartNotebookExportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
