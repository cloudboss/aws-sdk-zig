const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetLogRecordInput = struct {
    /// The pointer corresponding to the log event record you want to retrieve. You
    /// get this from
    /// the response of a `GetQueryResults` operation. In that response, the value
    /// of the
    /// `@ptr` field for a log event is the value to use as `logRecordPointer`
    /// to retrieve that complete log event record.
    log_record_pointer: []const u8,

    /// Specify `true` to display the log event fields with all sensitive data
    /// unmasked
    /// and visible. The default is `false`.
    ///
    /// To use this operation with this parameter, you must be signed into an
    /// account with the
    /// `logs:Unmask` permission.
    unmask: ?bool = null,

    pub const json_field_names = .{
        .log_record_pointer = "logRecordPointer",
        .unmask = "unmask",
    };
};

pub const GetLogRecordOutput = struct {
    /// The requested log event, as a JSON string.
    log_record: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .log_record = "logRecord",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLogRecordInput, options: CallOptions) !GetLogRecordOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLogRecordInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.GetLogRecord");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLogRecordOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetLogRecordOutput, body, allocator);
}
