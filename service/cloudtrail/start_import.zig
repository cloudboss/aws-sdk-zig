const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportSource = @import("import_source.zig").ImportSource;
const ImportStatus = @import("import_status.zig").ImportStatus;

pub const StartImportInput = struct {
    /// The ARN of the destination event data store. Use this parameter for a new
    /// import.
    destinations: ?[]const []const u8 = null,

    /// Use with `StartEventTime` to bound a `StartImport` request, and
    /// limit imported trail events to only those events logged within a specified
    /// time period.
    /// When you specify a time range, CloudTrail checks the prefix and log file
    /// names to
    /// verify the names contain a date between the specified `StartEventTime` and
    /// `EndEventTime` before attempting to import events.
    end_event_time: ?i64 = null,

    /// The ID of the import. Use this parameter when you are retrying an import.
    import_id: ?[]const u8 = null,

    /// The source S3 bucket for the import. Use this parameter for a new import.
    import_source: ?ImportSource = null,

    /// Use with `EndEventTime` to bound a `StartImport` request, and
    /// limit imported trail events to only those events logged within a specified
    /// time period.
    /// When you specify a time range, CloudTrail checks the prefix and log file
    /// names to
    /// verify the names contain a date between the specified `StartEventTime` and
    /// `EndEventTime` before attempting to import events.
    start_event_time: ?i64 = null,

    pub const json_field_names = .{
        .destinations = "Destinations",
        .end_event_time = "EndEventTime",
        .import_id = "ImportId",
        .import_source = "ImportSource",
        .start_event_time = "StartEventTime",
    };
};

pub const StartImportOutput = struct {
    /// The timestamp for the import's creation.
    created_timestamp: ?i64 = null,

    /// The ARN of the destination event data store.
    destinations: ?[]const []const u8 = null,

    /// Used with `StartEventTime` to bound a `StartImport` request, and
    /// limit imported trail events to only those events logged within a specified
    /// time period.
    end_event_time: ?i64 = null,

    /// The ID of the import.
    import_id: ?[]const u8 = null,

    /// The source S3 bucket for the import.
    import_source: ?ImportSource = null,

    /// Shows the status of the import after a `StartImport` request. An import
    /// finishes with a status of `COMPLETED` if there were no failures, or
    /// `FAILED` if there were failures.
    import_status: ?ImportStatus = null,

    /// Used with `EndEventTime` to bound a `StartImport` request, and
    /// limit imported trail events to only those events logged within a specified
    /// time period.
    start_event_time: ?i64 = null,

    /// The timestamp of the import's last update, if applicable.
    updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .destinations = "Destinations",
        .end_event_time = "EndEventTime",
        .import_id = "ImportId",
        .import_source = "ImportSource",
        .import_status = "ImportStatus",
        .start_event_time = "StartEventTime",
        .updated_timestamp = "UpdatedTimestamp",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartImportInput, options: CallOptions) !StartImportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartImportInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.StartImport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartImportOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartImportOutput, body, allocator);
}
