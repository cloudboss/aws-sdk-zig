const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FilterCondition = @import("filter_condition.zig").FilterCondition;
const ResourceInfo = @import("resource_info.zig").ResourceInfo;

pub const ListResourcesInput = struct {
    /// Any applicable row-level and/or column-level filtering conditions for the
    /// resources.
    filter_condition_list: ?[]const FilterCondition = null,

    /// The maximum number of resource results.
    max_results: ?i32 = null,

    /// A continuation token, if this is not the first call to retrieve these
    /// resources.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter_condition_list = "FilterConditionList",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListResourcesOutput = struct {
    /// A continuation token, if this is not the first call to retrieve these
    /// resources.
    next_token: ?[]const u8 = null,

    /// A summary of the data lake resources.
    resource_info_list: ?[]const ResourceInfo = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_info_list = "ResourceInfoList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourcesInput, options: CallOptions) !ListResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lakeformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListResources";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter_condition_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FilterConditionList\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourcesOutput {
    const result: ListResourcesOutput = try aws.json.parseJsonObject(
        ListResourcesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
