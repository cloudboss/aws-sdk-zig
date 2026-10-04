const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstancePropertyStringFilter = @import("instance_property_string_filter.zig").InstancePropertyStringFilter;
const InstancePropertyFilter = @import("instance_property_filter.zig").InstancePropertyFilter;
const InstanceProperty = @import("instance_property.zig").InstanceProperty;

pub const DescribeInstancePropertiesInput = struct {
    /// The request filters to use with the operator.
    filters_with_operator: ?[]const InstancePropertyStringFilter = null,

    /// An array of instance property filters.
    instance_property_filter_list: ?[]const InstancePropertyFilter = null,

    /// The maximum number of items to return for the call. The call also returns a
    /// token that you
    /// can specify in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// The token provided by a previous request to use to return the next set of
    /// properties.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters_with_operator = "FiltersWithOperator",
        .instance_property_filter_list = "InstancePropertyFilterList",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribeInstancePropertiesOutput = struct {
    /// Properties for the managed instances.
    instance_properties: ?[]const InstanceProperty = null,

    /// The token for the next set of properties to return. Use this token to get
    /// the next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_properties = "InstanceProperties",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInstancePropertiesInput, options: CallOptions) !DescribeInstancePropertiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInstancePropertiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribeInstanceProperties");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInstancePropertiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeInstancePropertiesOutput, body, allocator);
}
