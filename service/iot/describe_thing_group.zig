const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DynamicGroupStatus = @import("dynamic_group_status.zig").DynamicGroupStatus;
const ThingGroupMetadata = @import("thing_group_metadata.zig").ThingGroupMetadata;
const ThingGroupProperties = @import("thing_group_properties.zig").ThingGroupProperties;

pub const DescribeThingGroupInput = struct {
    /// The name of the thing group.
    thing_group_name: []const u8,

    pub const json_field_names = .{
        .thing_group_name = "thingGroupName",
    };
};

pub const DescribeThingGroupOutput = struct {
    /// The dynamic thing group index name.
    index_name: ?[]const u8 = null,

    /// The dynamic thing group search query string.
    query_string: ?[]const u8 = null,

    /// The dynamic thing group query version.
    query_version: ?[]const u8 = null,

    /// The dynamic thing group status.
    status: ?DynamicGroupStatus = null,

    /// The thing group ARN.
    thing_group_arn: ?[]const u8 = null,

    /// The thing group ID.
    thing_group_id: ?[]const u8 = null,

    /// Thing group metadata.
    thing_group_metadata: ?ThingGroupMetadata = null,

    /// The name of the thing group.
    thing_group_name: ?[]const u8 = null,

    /// The thing group properties.
    thing_group_properties: ?ThingGroupProperties = null,

    /// The version of the thing group.
    version: ?i64 = null,

    pub const json_field_names = .{
        .index_name = "indexName",
        .query_string = "queryString",
        .query_version = "queryVersion",
        .status = "status",
        .thing_group_arn = "thingGroupArn",
        .thing_group_id = "thingGroupId",
        .thing_group_metadata = "thingGroupMetadata",
        .thing_group_name = "thingGroupName",
        .thing_group_properties = "thingGroupProperties",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeThingGroupInput, options: CallOptions) !DescribeThingGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeThingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/thing-groups/");
    try path_buf.appendSlice(allocator, input.thing_group_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeThingGroupOutput {
    const result: DescribeThingGroupOutput = try aws.json.parseJsonObject(
        DescribeThingGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
