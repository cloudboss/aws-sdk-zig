const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportExportFileFormat = @import("import_export_file_format.zig").ImportExportFileFormat;
const ExportResourceSpecification = @import("export_resource_specification.zig").ExportResourceSpecification;
const ExportStatus = @import("export_status.zig").ExportStatus;

pub const CreateExportInput = struct {
    /// The file format of the bot or bot locale definition files.
    file_format: ImportExportFileFormat,

    /// An password to use to encrypt the exported archive. Using a password
    /// is optional, but you should encrypt the archive to protect the data in
    /// transit between Amazon Lex and your local computer.
    file_password: ?[]const u8 = null,

    /// Specifies the type of resource to export, either a bot or a bot
    /// locale. You can only specify one type of resource to export.
    resource_specification: ExportResourceSpecification,

    pub const json_field_names = .{
        .file_format = "fileFormat",
        .file_password = "filePassword",
        .resource_specification = "resourceSpecification",
    };
};

pub const CreateExportOutput = struct {
    /// The date and time that the request to export a bot was
    /// created.
    creation_date_time: ?i64 = null,

    /// An identifier for a specific request to create an export.
    export_id: ?[]const u8 = null,

    /// The status of the export. When the status is `Completed`,
    /// you can use the
    /// [DescribeExport](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_DescribeExport.html) operation to get the
    /// pre-signed S3 URL link to your exported bot or bot locale.
    export_status: ?ExportStatus = null,

    /// The file format used for the bot or bot locale definition
    /// files.
    file_format: ?ImportExportFileFormat = null,

    /// A description of the type of resource that was exported, either a
    /// bot or a bot locale.
    resource_specification: ?ExportResourceSpecification = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .export_id = "exportId",
        .export_status = "exportStatus",
        .file_format = "fileFormat",
        .resource_specification = "resourceSpecification",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateExportInput, options: CallOptions) !CreateExportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/exports";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"fileFormat\":");
    try aws.json.writeValue(@TypeOf(input.file_format), input.file_format, allocator, &body_buf);
    has_prev = true;
    if (input.file_password) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filePassword\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceSpecification\":");
    try aws.json.writeValue(@TypeOf(input.resource_specification), input.resource_specification, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateExportOutput {
    var result: CreateExportOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateExportOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
