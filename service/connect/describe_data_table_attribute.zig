const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataTableAttribute = @import("data_table_attribute.zig").DataTableAttribute;

pub const DescribeDataTableAttributeInput = struct {
    /// The name of the attribute to retrieve detailed information for.
    attribute_name: []const u8,

    /// The unique identifier for the data table. Must also accept the table ARN
    /// with or without a version alias.
    data_table_id: []const u8,

    /// The unique identifier for the Amazon Connect instance.
    instance_id: []const u8,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .data_table_id = "DataTableId",
        .instance_id = "InstanceId",
    };
};

pub const DescribeDataTableAttributeOutput = struct {
    /// The complete attribute information including configuration, validation
    /// rules, lock version, and metadata.
    attribute: ?DataTableAttribute = null,

    pub const json_field_names = .{
        .attribute = "Attribute",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDataTableAttributeInput, options: CallOptions) !DescribeDataTableAttributeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDataTableAttributeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/data-tables/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.data_table_id);
    try path_buf.appendSlice(allocator, "/attributes/");
    try path_buf.appendSlice(allocator, input.attribute_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDataTableAttributeOutput {
    var result: DescribeDataTableAttributeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDataTableAttributeOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
