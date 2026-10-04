const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportStatus = @import("export_status.zig").ExportStatus;
const ImportExportFileFormat = @import("import_export_file_format.zig").ImportExportFileFormat;
const ExportResourceSpecification = @import("export_resource_specification.zig").ExportResourceSpecification;

pub const DescribeExportInput = struct {
    /// The unique identifier of the export to describe.
    export_id: []const u8,

    pub const json_field_names = .{
        .export_id = "exportId",
    };
};

pub const DescribeExportOutput = struct {
    /// The date and time that the export was created.
    creation_date_time: ?i64 = null,

    /// A pre-signed S3 URL that points to the bot or bot locale archive.
    /// The URL is only available for 5 minutes after calling the
    /// `DescribeExport` operation.
    download_url: ?[]const u8 = null,

    /// The unique identifier of the described export.
    export_id: ?[]const u8 = null,

    /// The status of the export. When the status is `Complete`
    /// the export archive file is available for download.
    export_status: ?ExportStatus = null,

    /// If the `exportStatus` is failed, contains one or more
    /// reasons why the export could not be completed.
    failure_reasons: ?[]const []const u8 = null,

    /// The file format used in the files that describe the resource.
    file_format: ?ImportExportFileFormat = null,

    /// The last date and time that the export was updated.
    last_updated_date_time: ?i64 = null,

    /// The bot, bot ID, and optional locale ID of the exported bot or bot
    /// locale.
    resource_specification: ?ExportResourceSpecification = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .download_url = "downloadUrl",
        .export_id = "exportId",
        .export_status = "exportStatus",
        .failure_reasons = "failureReasons",
        .file_format = "fileFormat",
        .last_updated_date_time = "lastUpdatedDateTime",
        .resource_specification = "resourceSpecification",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeExportInput, options: CallOptions) !DescribeExportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/exports/");
    try path_buf.appendSlice(allocator, input.export_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeExportOutput {
    const result: DescribeExportOutput = try aws.json.parseJsonObject(
        DescribeExportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
