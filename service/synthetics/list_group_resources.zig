const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListGroupResourcesInput = struct {
    /// Specifies the group to return information for. You can specify the group
    /// name, the ARN, or the
    /// group ID as the `GroupIdentifier`.
    group_identifier: []const u8,

    /// Specify this parameter to limit how many canary ARNs are returned each time
    /// you use
    /// the `ListGroupResources` operation. If you omit this parameter, the default
    /// of 20 is used.
    max_results: ?i32 = null,

    /// A token that indicates that there is more data
    /// available. You can use this token in a subsequent operation to retrieve the
    /// next
    /// set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_identifier = "GroupIdentifier",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListGroupResourcesOutput = struct {
    /// A token that indicates that there is more data
    /// available. You can use this token in a subsequent `ListGroupResources`
    /// operation to retrieve the next
    /// set of results.
    next_token: ?[]const u8 = null,

    /// An array of ARNs. These ARNs are for the canaries that are associated with
    /// the group.
    resources: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resources = "Resources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGroupResourcesInput, options: CallOptions) !ListGroupResourcesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListGroupResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("synthetics", "synthetics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/group/");
    try path_buf.appendSlice(allocator, input.group_identifier);
    try path_buf.appendSlice(allocator, "/resources");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListGroupResourcesOutput {
    const result: ListGroupResourcesOutput = try aws.json.parseJsonObject(
        ListGroupResourcesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
