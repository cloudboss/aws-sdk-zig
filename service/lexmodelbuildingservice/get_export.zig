const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportType = @import("export_type.zig").ExportType;
const ResourceType = @import("resource_type.zig").ResourceType;
const ExportStatus = @import("export_status.zig").ExportStatus;

pub const GetExportInput = struct {
    /// The format of the exported data.
    export_type: ExportType,

    /// The name of the bot to export.
    name: []const u8,

    /// The type of resource to export.
    resource_type: ResourceType,

    /// The version of the bot to export.
    version: []const u8,

    pub const json_field_names = .{
        .export_type = "exportType",
        .name = "name",
        .resource_type = "resourceType",
        .version = "version",
    };
};

pub const GetExportOutput = struct {
    /// The status of the export.
    ///
    /// * `IN_PROGRESS` - The export is in progress.
    ///
    /// * `READY` - The export is complete.
    ///
    /// * `FAILED` - The export could not be
    /// completed.
    export_status: ?ExportStatus = null,

    /// The format of the exported data.
    export_type: ?ExportType = null,

    /// If `status` is `FAILED`, Amazon Lex provides the
    /// reason that it failed to export the resource.
    failure_reason: ?[]const u8 = null,

    /// The name of the bot being exported.
    name: ?[]const u8 = null,

    /// The type of the exported resource.
    resource_type: ?ResourceType = null,

    /// An S3 pre-signed URL that provides the location of the exported
    /// resource. The exported resource is a ZIP archive that contains the
    /// exported resource in JSON format. The structure of the archive may change.
    /// Your code should not rely on the archive structure.
    url: ?[]const u8 = null,

    /// The version of the bot being exported.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .export_status = "exportStatus",
        .export_type = "exportType",
        .failure_reason = "failureReason",
        .name = "name",
        .resource_type = "resourceType",
        .url = "url",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExportInput, options: CallOptions) !GetExportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/exports";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "exportType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.export_type.wireName());
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "name=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.name);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "resourceType=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.resource_type.wireName());
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "version=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.version);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExportOutput {
    const result: GetExportOutput = try aws.json.parseJsonObject(
        GetExportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
