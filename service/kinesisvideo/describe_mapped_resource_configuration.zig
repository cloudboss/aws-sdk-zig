const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MappedResourceConfigurationListItem = @import("mapped_resource_configuration_list_item.zig").MappedResourceConfigurationListItem;

pub const DescribeMappedResourceConfigurationInput = struct {
    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// The token to provide in your next request, to get another batch of results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the stream.
    stream_arn: ?[]const u8 = null,

    /// The name of the stream.
    stream_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
    };
};

pub const DescribeMappedResourceConfigurationOutput = struct {
    /// A structure that encapsulates, or contains, the media storage configuration
    /// properties.
    mapped_resource_configuration_list: ?[]const MappedResourceConfigurationListItem = null,

    /// The token that was used in the `NextToken`request to fetch the next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .mapped_resource_configuration_list = "MappedResourceConfigurationList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMappedResourceConfigurationInput, options: CallOptions) !DescribeMappedResourceConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMappedResourceConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/describeMappedResourceConfiguration";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMappedResourceConfigurationOutput {
    var result: DescribeMappedResourceConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeMappedResourceConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
