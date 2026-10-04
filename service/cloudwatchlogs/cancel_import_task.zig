const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportStatistics = @import("import_statistics.zig").ImportStatistics;
const ImportStatus = @import("import_status.zig").ImportStatus;

pub const CancelImportTaskInput = struct {
    /// The ID of the import task to cancel.
    import_id: []const u8,

    pub const json_field_names = .{
        .import_id = "importId",
    };
};

pub const CancelImportTaskOutput = struct {
    /// The timestamp when the import task was created, expressed as the number of
    /// milliseconds after Jan 1, 1970 00:00:00 UTC.
    creation_time: ?i64 = null,

    /// The ID of the cancelled import task.
    import_id: ?[]const u8 = null,

    /// Statistics about the import progress at the time of cancellation.
    import_statistics: ?ImportStatistics = null,

    /// The final status of the import task. This will be set to CANCELLED.
    import_status: ?ImportStatus = null,

    /// The timestamp when the import task was cancelled, expressed as the number of
    /// milliseconds after Jan 1, 1970 00:00:00 UTC.
    last_updated_time: ?i64 = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .import_id = "importId",
        .import_statistics = "importStatistics",
        .import_status = "importStatus",
        .last_updated_time = "lastUpdatedTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelImportTaskInput, options: CallOptions) !CancelImportTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelImportTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.CancelImportTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelImportTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CancelImportTaskOutput, body, allocator);
}
