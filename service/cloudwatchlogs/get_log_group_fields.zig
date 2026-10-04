const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogGroupField = @import("log_group_field.zig").LogGroupField;

pub const GetLogGroupFieldsInput = struct {
    /// Specify either the name or ARN of the log group to view. If the log group is
    /// in a source
    /// account and you are using a monitoring account, you must specify the ARN.
    ///
    /// You must include either `logGroupIdentifier` or `logGroupName`,
    /// but not both.
    log_group_identifier: ?[]const u8 = null,

    /// The name of the log group to search.
    ///
    /// You must include either `logGroupIdentifier` or `logGroupName`,
    /// but not both.
    log_group_name: ?[]const u8 = null,

    /// The time to set as the center of the query. If you specify `time`, the 8
    /// minutes before and 8 minutes after this time are searched. If you omit
    /// `time`, the
    /// most recent 15 minutes up to the current time are searched.
    ///
    /// The `time` value is specified as epoch time, which is the number of seconds
    /// since `January 1, 1970, 00:00:00 UTC`.
    time: ?i64 = null,

    pub const json_field_names = .{
        .log_group_identifier = "logGroupIdentifier",
        .log_group_name = "logGroupName",
        .time = "time",
    };
};

pub const GetLogGroupFieldsOutput = struct {
    /// The array of fields found in the query. Each object in the array contains
    /// the name of the
    /// field, along with the percentage of time it appeared in the log events that
    /// were
    /// queried.
    log_group_fields: ?[]const LogGroupField = null,

    pub const json_field_names = .{
        .log_group_fields = "logGroupFields",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLogGroupFieldsInput, options: CallOptions) !GetLogGroupFieldsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLogGroupFieldsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.GetLogGroupFields");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLogGroupFieldsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetLogGroupFieldsOutput, body, allocator);
}
