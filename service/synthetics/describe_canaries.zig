const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Canary = @import("canary.zig").Canary;

pub const DescribeCanariesInput = struct {
    /// Specify this parameter to limit how many canaries are returned each time you
    /// use
    /// the `DescribeCanaries` operation. If you omit this parameter, the default of
    /// 20 is used.
    max_results: ?i32 = null,

    /// Use this parameter to return only canaries that match the names that you
    /// specify here. You can
    /// specify as many as five canary names.
    ///
    /// If you specify this parameter, the operation is successful only if you have
    /// authorization to view
    /// all the canaries that you specify in your request. If you do not have
    /// permission to view any of
    /// the canaries, the request fails with a 403 response.
    ///
    /// You are required to use this parameter if you are logged on to a user or
    /// role that has an
    /// IAM policy that restricts which canaries that you are allowed to view. For
    /// more information,
    /// see [
    /// Limiting a user to viewing specific
    /// canaries](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_Restricted.html).
    names: ?[]const []const u8 = null,

    /// A token that indicates that there is more data
    /// available. You can use this token in a subsequent operation to retrieve the
    /// next
    /// set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .names = "Names",
        .next_token = "NextToken",
    };
};

pub const DescribeCanariesOutput = struct {
    /// Returns an array. Each item in the array contains the full information about
    /// one canary.
    canaries: ?[]const Canary = null,

    /// A token that indicates that there is more data
    /// available. You can use this token in a subsequent `DescribeCanaries`
    /// operation to retrieve the next
    /// set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .canaries = "Canaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCanariesInput, options: CallOptions) !DescribeCanariesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "synthetics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCanariesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("synthetics", "synthetics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/canaries";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.names) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Names\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCanariesOutput {
    var result: DescribeCanariesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeCanariesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
