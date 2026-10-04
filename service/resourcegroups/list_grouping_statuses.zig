const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListGroupingStatusesFilter = @import("list_grouping_statuses_filter.zig").ListGroupingStatusesFilter;
const GroupingStatusesItem = @import("grouping_statuses_item.zig").GroupingStatusesItem;

pub const ListGroupingStatusesInput = struct {
    /// The filter name and value pair that is used to return more
    /// specific results from a list of resources.
    filters: ?[]const ListGroupingStatusesFilter = null,

    /// The application group identifier, expressed as an Amazon resource name (ARN)
    /// or the application group name.
    group: []const u8,

    /// The maximum number of resources and their statuses returned in the
    /// response.
    max_results: ?i32 = null,

    /// The parameter for receiving additional results if you receive a
    /// `NextToken` response in a previous request. A `NextToken`
    /// response indicates that more output is available. Set this parameter to the
    /// value provided by a previous call's `NextToken` response to indicate
    /// where the output should continue from.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .group = "Group",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListGroupingStatusesOutput = struct {
    /// The application group identifier, expressed as an Amazon resource name (ARN)
    /// or the application group name.
    group: ?[]const u8 = null,

    /// Returns details about the grouping or ungrouping status of the
    /// resources in the specified application group.
    grouping_statuses: ?[]const GroupingStatusesItem = null,

    /// If present, indicates that more output is available than is included in the
    /// current response.
    /// Use this value in the `NextToken` request parameter in a subsequent call to
    /// the operation to get the next part of the output.
    /// You should repeat this until the `NextToken` response element comes back as
    /// `null`.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .group = "Group",
        .grouping_statuses = "GroupingStatuses",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGroupingStatusesInput, options: CallOptions) !ListGroupingStatusesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resource-groups", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListGroupingStatusesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-groups", "Resource Groups", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-grouping-statuses";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Group\":");
    try aws.json.writeValue(@TypeOf(input.group), input.group, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListGroupingStatusesOutput {
    const result: ListGroupingStatusesOutput = try aws.json.parseJsonObject(
        ListGroupingStatusesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
