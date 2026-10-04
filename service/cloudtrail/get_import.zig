const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportSource = @import("import_source.zig").ImportSource;
const ImportStatistics = @import("import_statistics.zig").ImportStatistics;
const ImportStatus = @import("import_status.zig").ImportStatus;

pub const GetImportInput = struct {
    /// The ID for the import.
    import_id: []const u8,

    pub const json_field_names = .{
        .import_id = "ImportId",
    };
};

pub const GetImportOutput = struct {
    /// The timestamp of the import's creation.
    created_timestamp: ?i64 = null,

    /// The ARN of the destination event data store.
    destinations: ?[]const []const u8 = null,

    /// Used with `StartEventTime` to bound a `StartImport` request, and
    /// limit imported trail events to only those events logged within a specified
    /// time period.
    end_event_time: ?i64 = null,

    /// The ID of the import.
    import_id: ?[]const u8 = null,

    /// The source S3 bucket.
    import_source: ?ImportSource = null,

    /// Provides statistics for the import. CloudTrail does not update import
    /// statistics
    /// in real-time. Returned values for parameters such as `EventsCompleted` may
    /// be
    /// lower than the actual value, because CloudTrail updates statistics
    /// incrementally
    /// over the course of the import.
    import_statistics: ?ImportStatistics = null,

    /// The status of the import.
    import_status: ?ImportStatus = null,

    /// Used with `EndEventTime` to bound a `StartImport` request, and
    /// limit imported trail events to only those events logged within a specified
    /// time period.
    start_event_time: ?i64 = null,

    /// The timestamp of when the import was updated.
    updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .destinations = "Destinations",
        .end_event_time = "EndEventTime",
        .import_id = "ImportId",
        .import_source = "ImportSource",
        .import_statistics = "ImportStatistics",
        .import_status = "ImportStatus",
        .start_event_time = "StartEventTime",
        .updated_timestamp = "UpdatedTimestamp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetImportInput, options: CallOptions) !GetImportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetImportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.GetImport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetImportOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetImportOutput, body, allocator);
}
