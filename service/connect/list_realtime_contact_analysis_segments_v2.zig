const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RealTimeContactAnalysisOutputType = @import("real_time_contact_analysis_output_type.zig").RealTimeContactAnalysisOutputType;
const RealTimeContactAnalysisSegmentType = @import("real_time_contact_analysis_segment_type.zig").RealTimeContactAnalysisSegmentType;
const RealTimeContactAnalysisSupportedChannel = @import("real_time_contact_analysis_supported_channel.zig").RealTimeContactAnalysisSupportedChannel;
const RealtimeContactAnalysisSegment = @import("realtime_contact_analysis_segment.zig").RealtimeContactAnalysisSegment;
const RealTimeContactAnalysisStatus = @import("real_time_contact_analysis_status.zig").RealTimeContactAnalysisStatus;

pub const ListRealtimeContactAnalysisSegmentsV2Input = struct {
    /// The identifier of the contact in this instance of Amazon Connect.
    contact_id: []const u8,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous
    /// response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The Contact Lens output type to be returned.
    output_type: RealTimeContactAnalysisOutputType,

    /// Enum with segment types . Each value corresponds to a segment type returned
    /// in the segments list of the API.
    /// Each segment type has its own structure. Different channels may have
    /// different sets of supported segment
    /// types.
    segment_types: []const RealTimeContactAnalysisSegmentType,

    pub const json_field_names = .{
        .contact_id = "ContactId",
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .output_type = "OutputType",
        .segment_types = "SegmentTypes",
    };
};

pub const ListRealtimeContactAnalysisSegmentsV2Output = struct {
    /// The channel of the contact.
    ///
    /// Only `CHAT` is supported. This API does not support `VOICE`. If you attempt
    /// to use it for
    /// the VOICE channel, an `InvalidRequestException` error occurs.
    channel: RealTimeContactAnalysisSupportedChannel,

    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// An analyzed transcript or category.
    segments: ?[]const RealtimeContactAnalysisSegment = null,

    /// Status of real-time contact analysis.
    status: RealTimeContactAnalysisStatus,

    pub const json_field_names = .{
        .channel = "Channel",
        .next_token = "NextToken",
        .segments = "Segments",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRealtimeContactAnalysisSegmentsV2Input, options: CallOptions) !ListRealtimeContactAnalysisSegmentsV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRealtimeContactAnalysisSegmentsV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/contact/list-real-time-analysis-segments-v2/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.contact_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutputType\":");
    try aws.json.writeValue(@TypeOf(input.output_type), input.output_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SegmentTypes\":");
    try aws.json.writeValue(@TypeOf(input.segment_types), input.segment_types, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRealtimeContactAnalysisSegmentsV2Output {
    var result: ListRealtimeContactAnalysisSegmentsV2Output = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListRealtimeContactAnalysisSegmentsV2Output, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
