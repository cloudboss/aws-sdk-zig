const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotebookExportError = @import("notebook_export_error.zig").NotebookExportError;
const FileFormat = @import("file_format.zig").FileFormat;
const OutputLocation = @import("output_location.zig").OutputLocation;
const NotebookExportStatus = @import("notebook_export_status.zig").NotebookExportStatus;

pub const GetNotebookExportInput = struct {
    /// The identifier of the Amazon SageMaker Unified Studio domain in which the
    /// notebook export exists.
    domain_identifier: []const u8,

    /// The identifier of the notebook export.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const GetNotebookExportOutput = struct {
    /// The timestamp of when the notebook export completed.
    completed_at: ?i64 = null,

    /// The timestamp of when the notebook export was started.
    created_at: ?i64 = null,

    /// The identifier of the user who started the notebook export.
    created_by: ?[]const u8 = null,

    /// The identifier of the Amazon SageMaker Unified Studio domain.
    domain_id: []const u8,

    /// The error details if the notebook export failed.
    @"error": ?NotebookExportError = null,

    /// The file format of the notebook export.
    file_format: FileFormat,

    /// The identifier of the notebook export.
    id: []const u8,

    /// The identifier of the notebook.
    notebook_id: []const u8,

    /// The output location of the exported notebook in Amazon Simple Storage
    /// Service.
    output_location: ?OutputLocation = null,

    /// The identifier of the project that owns the notebook.
    owning_project_id: []const u8,

    /// The status of the notebook export.
    status: NotebookExportStatus,

    pub const json_field_names = .{
        .completed_at = "completedAt",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .@"error" = "error",
        .file_format = "fileFormat",
        .id = "id",
        .notebook_id = "notebookId",
        .output_location = "outputLocation",
        .owning_project_id = "owningProjectId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetNotebookExportInput, options: CallOptions) !GetNotebookExportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetNotebookExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/notebook-exports/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetNotebookExportOutput {
    const result: GetNotebookExportOutput = try aws.json.parseJsonObject(
        GetNotebookExportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
