const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateDataRetentionOperation = @import("update_data_retention_operation.zig").UpdateDataRetentionOperation;

pub const UpdateDataRetentionInput = struct {
    /// The version of the stream whose retention period you want to change. To get
    /// the
    /// version, call either the `DescribeStream` or the `ListStreams`
    /// API.
    current_version: []const u8,

    /// The number of hours to adjust the current retention by. The value you
    /// specify is added to or subtracted from the current value, depending on the
    /// `operation`.
    ///
    /// The minimum value for data retention is 0 and the maximum value is 87600
    /// (ten years).
    data_retention_change_in_hours: i32,

    /// Indicates whether you want to increase or decrease the retention period.
    operation: UpdateDataRetentionOperation,

    /// The Amazon Resource Name (ARN) of the stream whose retention period you want
    /// to
    /// change.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream whose retention period you want to change.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_version = "CurrentVersion",
        .data_retention_change_in_hours = "DataRetentionChangeInHours",
        .operation = "Operation",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
    };
};

pub const UpdateDataRetentionOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataRetentionInput, options: CallOptions) !UpdateDataRetentionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisvideo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataRetentionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/updateDataRetention";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CurrentVersion\":");
    try aws.json.writeValue(@TypeOf(input.current_version), input.current_version, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DataRetentionChangeInHours\":");
    try aws.json.writeValue(@TypeOf(input.data_retention_change_in_hours), input.data_retention_change_in_hours, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Operation\":");
    try aws.json.writeValue(@TypeOf(input.operation), input.operation, allocator, &body_buf);
    has_prev = true;
    if (input.stream_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamARN\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stream_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDataRetentionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateDataRetentionOutput = .{};

    return result;
}
