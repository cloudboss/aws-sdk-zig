const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserDataFilters = @import("user_data_filters.zig").UserDataFilters;
const UserData = @import("user_data.zig").UserData;

pub const GetCurrentUserDataInput = struct {
    /// The filters to apply to returned user data. You can filter up to the
    /// following limits:
    ///
    /// * Queues: 100
    ///
    /// * Routing profiles: 100
    ///
    /// * Agents: 100
    ///
    /// * Contact states: 9
    ///
    /// * User hierarchy groups: 1
    ///
    /// The user data is retrieved for only the specified values/resources in the
    /// filter. A maximum of one filter can
    /// be passed from queues, routing profiles, agents, and user hierarchy groups.
    ///
    /// Currently tagging is only supported on the resources that are passed in the
    /// filter.
    filters: UserDataFilters,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous
    /// response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const GetCurrentUserDataOutput = struct {
    /// The total count of the result, regardless of the current page size.
    approximate_total_count: ?i64 = null,

    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// A list of the user data that is returned.
    user_data_list: ?[]const UserData = null,

    pub const json_field_names = .{
        .approximate_total_count = "ApproximateTotalCount",
        .next_token = "NextToken",
        .user_data_list = "UserDataList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCurrentUserDataInput, options: CallOptions) !GetCurrentUserDataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCurrentUserDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/metrics/userdata/");
    try path_buf.appendSlice(allocator, input.instance_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Filters\":");
    try aws.json.writeValue(@TypeOf(input.filters), input.filters, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCurrentUserDataOutput {
    const result: GetCurrentUserDataOutput = try aws.json.parseJsonObject(
        GetCurrentUserDataOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
