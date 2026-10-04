const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const EventCategoryGroup = @import("event_category_group.zig").EventCategoryGroup;

pub const DescribeEventCategoriesInput = struct {
    /// Filters applied to the event categories.
    filters: ?[]const Filter = null,

    /// The type of DMS resource that generates events.
    ///
    /// Valid values: replication-instance | replication-task
    source_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .source_type = "SourceType",
    };
};

pub const DescribeEventCategoriesOutput = struct {
    /// A list of event categories.
    event_category_group_list: ?[]const EventCategoryGroup = null,

    pub const json_field_names = .{
        .event_category_group_list = "EventCategoryGroupList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEventCategoriesInput, options: CallOptions) !DescribeEventCategoriesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEventCategoriesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.DescribeEventCategories");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEventCategoriesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEventCategoriesOutput, body, allocator);
}
