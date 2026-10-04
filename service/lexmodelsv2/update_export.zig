const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportStatus = @import("export_status.zig").ExportStatus;
const ImportExportFileFormat = @import("import_export_file_format.zig").ImportExportFileFormat;
const ExportResourceSpecification = @import("export_resource_specification.zig").ExportResourceSpecification;

pub const UpdateExportInput = struct {
    /// The unique identifier Amazon Lex assigned to the export.
    export_id: []const u8,

    /// The new password to use to encrypt the export zip archive.
    file_password: ?[]const u8 = null,

    pub const json_field_names = .{
        .export_id = "exportId",
        .file_password = "filePassword",
    };
};

pub const UpdateExportOutput = struct {
    /// The date and time that the export was created.
    creation_date_time: ?i64 = null,

    /// The unique identifier Amazon Lex assigned to the export.
    export_id: ?[]const u8 = null,

    /// The status of the export. When the status is `Completed`
    /// the export archive is available for download.
    export_status: ?ExportStatus = null,

    /// The file format used for the files that define the resource. The
    /// `TSV` format is required to export a custom vocabulary
    /// only; otherwise use `LexJson` format.
    file_format: ?ImportExportFileFormat = null,

    /// The date and time that the export was last updated.
    last_updated_date_time: ?i64 = null,

    /// A description of the type of resource that was exported, either a
    /// bot or a bot locale.
    resource_specification: ?ExportResourceSpecification = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .export_id = "exportId",
        .export_status = "exportStatus",
        .file_format = "fileFormat",
        .last_updated_date_time = "lastUpdatedDateTime",
        .resource_specification = "resourceSpecification",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateExportInput, options: CallOptions) !UpdateExportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/exports/");
    try path_buf.appendSlice(allocator, input.export_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.file_password) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filePassword\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateExportOutput {
    var result: UpdateExportOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateExportOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
