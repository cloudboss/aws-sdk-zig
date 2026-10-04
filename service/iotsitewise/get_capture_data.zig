const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TimeInNanos = @import("time_in_nanos.zig").TimeInNanos;
const FormatSettings = @import("format_settings.zig").FormatSettings;
const VideoDataType = @import("video_data_type.zig").VideoDataType;

pub const GetCaptureDataInput = struct {
    /// The end time for the video data range. Must be greater than startTime.
    end_time: TimeInNanos,

    /// The optional format settings for the output.
    format_settings: ?FormatSettings = null,

    /// The token from a previous response used to continue retrieving data.
    next_token: ?[]const u8 = null,

    /// The property alias that identifies the capture source. Mutually exclusive
    /// with timeSeriesId.
    property_alias: ?[]const u8 = null,

    /// The start time for the video data range.
    start_time: TimeInNanos,

    /// The time series ID that identifies the capture source. Mutually exclusive
    /// with propertyAlias.
    time_series_id: ?[]const u8 = null,

    /// The name of the workspace that contains the capture source.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .end_time = "endTime",
        .format_settings = "formatSettings",
        .next_token = "nextToken",
        .property_alias = "propertyAlias",
        .start_time = "startTime",
        .time_series_id = "timeSeriesId",
        .workspace_name = "workspaceName",
    };
};

pub const GetCaptureDataOutput = struct {
    /// The binary video data.
    data: []const u8,

    /// The type of the returned data.
    data_type: VideoDataType,

    /// The actual end time of the returned data.
    end_time: ?TimeInNanos = null,

    /// The token used to retrieve the next chunk. Absent if no more data is
    /// available.
    next_token: ?[]const u8 = null,

    /// The actual start time of the returned data.
    start_time: ?TimeInNanos = null,

    pub const json_field_names = .{
        .data = "data",
        .data_type = "dataType",
        .end_time = "endTime",
        .next_token = "nextToken",
        .start_time = "startTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCaptureDataInput, options: CallOptions) !GetCaptureDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCaptureDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/get-capture-data");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"endTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, allocator, &body_buf);
    has_prev = true;
    if (input.format_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"formatSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.property_alias) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"propertyAlias\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"startTime\":");
    try aws.json.writeValue(@TypeOf(input.start_time), input.start_time, allocator, &body_buf);
    has_prev = true;
    if (input.time_series_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"timeSeriesId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCaptureDataOutput {
    const result: GetCaptureDataOutput = try aws.json.parseJsonObject(
        GetCaptureDataOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
