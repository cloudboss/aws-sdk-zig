const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportDestinationConfiguration = @import("export_destination_configuration.zig").ExportDestinationConfiguration;
const ArchiveFilters = @import("archive_filters.zig").ArchiveFilters;
const ExportStatus = @import("export_status.zig").ExportStatus;

pub const GetArchiveExportInput = struct {
    /// The identifier of the export job to get details for.
    export_id: []const u8,

    pub const json_field_names = .{
        .export_id = "ExportId",
    };
};

pub const GetArchiveExportOutput = struct {
    /// The identifier of the archive the email export was performed from.
    archive_id: ?[]const u8 = null,

    /// Where the exported emails are being delivered.
    export_destination_configuration: ?ExportDestinationConfiguration = null,

    /// The criteria used to filter emails included in the export.
    filters: ?ArchiveFilters = null,

    /// The start of the timestamp range the exported emails cover.
    from_timestamp: ?i64 = null,

    /// The maximum number of email items included in the export.
    max_results: ?i32 = null,

    /// The current status of the export job.
    status: ?ExportStatus = null,

    /// The end of the date range the exported emails cover.
    to_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .archive_id = "ArchiveId",
        .export_destination_configuration = "ExportDestinationConfiguration",
        .filters = "Filters",
        .from_timestamp = "FromTimestamp",
        .max_results = "MaxResults",
        .status = "Status",
        .to_timestamp = "ToTimestamp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetArchiveExportInput, options: CallOptions) !GetArchiveExportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetArchiveExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mail-manager", "MailManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.GetArchiveExport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetArchiveExportOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetArchiveExportOutput, body, allocator);
}
