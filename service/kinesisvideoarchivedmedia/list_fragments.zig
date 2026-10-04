const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FragmentSelector = @import("fragment_selector.zig").FragmentSelector;
const Fragment = @import("fragment.zig").Fragment;

pub const ListFragmentsInput = struct {
    /// Describes the timestamp range and timestamp origin for the range of
    /// fragments to
    /// return.
    ///
    /// This is only required when the `NextToken` isn't passed in the API.
    fragment_selector: ?FragmentSelector = null,

    /// The total number of fragments to return. If the total number of fragments
    /// available is
    /// more than the value specified in `max-results`, then a
    /// ListFragmentsOutput$NextToken is provided in the output that you can use
    /// to resume pagination.
    max_results: ?i64 = null,

    /// A token to specify where to start paginating. This is the
    /// ListFragmentsOutput$NextToken from a previously truncated
    /// response.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the stream from which to retrieve a
    /// fragment list. Specify either this parameter or the `StreamName` parameter.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream from which to retrieve a fragment list. Specify
    /// either this parameter or the `StreamARN` parameter.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .fragment_selector = "FragmentSelector",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
    };
};

pub const ListFragmentsOutput = struct {
    /// A list of archived Fragment objects from the stream that meet the
    /// selector criteria. Results are in no specific order, even across pages.
    fragments: ?[]const Fragment = null,

    /// If the returned list is truncated, the operation returns this token to use
    /// to retrieve
    /// the next page of results. This value is `null` when there are no more
    /// results
    /// to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .fragments = "Fragments",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFragmentsInput, options: CallOptions) !ListFragmentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFragmentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video Archived Media", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/listFragments";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.fragment_selector) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FragmentSelector\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFragmentsOutput {
    var result: ListFragmentsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListFragmentsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
