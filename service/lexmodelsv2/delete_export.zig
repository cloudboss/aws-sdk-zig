const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportStatus = @import("export_status.zig").ExportStatus;

pub const DeleteExportInput = struct {
    /// The unique identifier of the export to delete.
    export_id: []const u8,

    pub const json_field_names = .{
        .export_id = "exportId",
    };
};

pub const DeleteExportOutput = struct {
    /// The unique identifier of the deleted export.
    export_id: ?[]const u8 = null,

    /// The current status of the deletion. When the deletion is complete,
    /// the export will no longer be returned by the
    /// [ListExports](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_ListExports.html) operation and calls to the [
    /// DescribeExport](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_DescribeExport.html) operation with the export identifier will
    /// fail.
    export_status: ?ExportStatus = null,

    pub const json_field_names = .{
        .export_id = "exportId",
        .export_status = "exportStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteExportInput, options: CallOptions) !DeleteExportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/exports/");
    try path_buf.appendSlice(allocator, input.export_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteExportOutput {
    const result: DeleteExportOutput = try aws.json.parseJsonObject(
        DeleteExportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
