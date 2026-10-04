const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceTagsSearchCriteria = @import("resource_tags_search_criteria.zig").ResourceTagsSearchCriteria;
const TagSet = @import("tag_set.zig").TagSet;

pub const SearchResourceTagsInput = struct {
    /// The identifier of the Connect Customer instance. You can find the instanceId
    /// in the Amazon Resource Name (ARN)
    /// of the instance.
    instance_id: []const u8,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to
    /// retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// The list of resource types to be used to search tags from. If not provided
    /// or if any empty list is provided,
    /// this API will search from all supported resource types. Note that lowercase
    /// and - are required.
    ///
    /// **Supported resource types**
    ///
    /// * agent
    ///
    /// * agent-state
    ///
    /// * routing-profile
    ///
    /// * standard-queue
    ///
    /// * security-profile
    ///
    /// * operating-hours
    ///
    /// * prompt
    ///
    /// * contact-flow
    ///
    /// * flow- module
    ///
    /// * transfer-destination (also known as quick connect)
    ///
    /// * metric
    resource_types: ?[]const []const u8 = null,

    /// The search criteria to be used to return tags.
    search_criteria: ?ResourceTagsSearchCriteria = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_types = "ResourceTypes",
        .search_criteria = "SearchCriteria",
    };
};

pub const SearchResourceTagsOutput = struct {
    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// A list of tags used in the Connect Customer instance.
    tags: ?[]const TagSet = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchResourceTagsInput, options: CallOptions) !SearchResourceTagsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchResourceTagsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/search-resource-tags";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstanceId\":");
    try aws.json.writeValue(@TypeOf(input.instance_id), input.instance_id, allocator, &body_buf);
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
    if (input.resource_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.search_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SearchCriteria\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchResourceTagsOutput {
    const result: SearchResourceTagsOutput = try aws.json.parseJsonObject(
        SearchResourceTagsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
