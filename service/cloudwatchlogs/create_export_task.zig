const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateExportTaskInput = struct {
    /// The name of S3 bucket for the exported log data. The bucket must be in the
    /// same Amazon Web Services Region.
    destination: []const u8,

    /// The prefix used as the start of the key for every object exported. If you
    /// don't specify
    /// a value, the default is `exportedlogs`.
    ///
    /// The length of this parameter must comply with the S3 object key name length
    /// limits. The
    /// object key name is a sequence of Unicode characters with UTF-8 encoding, and
    /// can be up to
    /// 1,024 bytes.
    destination_prefix: ?[]const u8 = null,

    /// The start time of the range for the request, expressed as the number of
    /// milliseconds
    /// after `Jan 1, 1970 00:00:00 UTC`. Events with a timestamp earlier than this
    /// time
    /// are not exported.
    from: i64,

    /// The name of the log group.
    log_group_name: []const u8,

    /// Export only log streams that match the provided prefix. If you don't specify
    /// a value,
    /// no prefix filter is applied.
    log_stream_name_prefix: ?[]const u8 = null,

    /// The name of the export task.
    task_name: ?[]const u8 = null,

    /// The end time of the range for the request, expressed as the number of
    /// milliseconds
    /// after `Jan 1, 1970 00:00:00 UTC`. Events with a timestamp later than this
    /// time are
    /// not exported.
    ///
    /// You must specify a time that is not earlier than when this log group was
    /// created.
    to: i64,

    pub const json_field_names = .{
        .destination = "destination",
        .destination_prefix = "destinationPrefix",
        .from = "from",
        .log_group_name = "logGroupName",
        .log_stream_name_prefix = "logStreamNamePrefix",
        .task_name = "taskName",
        .to = "to",
    };
};

pub const CreateExportTaskOutput = struct {
    /// The ID of the export task.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .task_id = "taskId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateExportTaskInput, options: CallOptions) !CreateExportTaskOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateExportTaskInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.CreateExportTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateExportTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateExportTaskOutput, body, allocator);
}
