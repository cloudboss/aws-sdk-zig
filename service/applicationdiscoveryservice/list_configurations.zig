const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfigurationItemType = @import("configuration_item_type.zig").ConfigurationItemType;
const Filter = @import("filter.zig").Filter;
const OrderByElement = @import("order_by_element.zig").OrderByElement;

pub const ListConfigurationsInput = struct {
    /// A valid configuration identified by Application Discovery Service.
    configuration_type: ConfigurationItemType,

    /// You can filter the request using various logical operators and a
    /// *key*-*value* format. For example:
    ///
    /// `{"key": "serverType", "value": "webServer"}`
    ///
    /// For a complete list of filter options and guidance about using them with
    /// this action,
    /// see [Using the ListConfigurations
    /// Action](https://docs.aws.amazon.com/application-discovery/latest/userguide/discovery-api-queries.html#ListConfigurations) in the *Amazon Web Services Application Discovery
    /// Service User Guide*.
    filters: ?[]const Filter = null,

    /// The total number of items to return. The maximum value is 100.
    max_results: ?i32 = null,

    /// Token to retrieve the next set of results. For example, if a previous call
    /// to
    /// ListConfigurations returned 100 items, but you set
    /// `ListConfigurationsRequest$maxResults` to 10, you received a set of 10
    /// results
    /// along with a token. Use that token in this query to get the next set of 10.
    next_token: ?[]const u8 = null,

    /// Certain filter criteria return output that can be sorted in ascending or
    /// descending
    /// order. For a list of output characteristics for each filter, see [Using the
    /// ListConfigurations
    /// Action](https://docs.aws.amazon.com/application-discovery/latest/userguide/discovery-api-queries.html#ListConfigurations) in the *Amazon Web Services Application Discovery
    /// Service User Guide*.
    order_by: ?[]const OrderByElement = null,

    pub const json_field_names = .{
        .configuration_type = "configurationType",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .order_by = "orderBy",
    };
};

pub const ListConfigurationsOutput = struct {
    /// Returns configuration details, including the configuration ID, attribute
    /// names, and
    /// attribute values.
    configurations: ?[]const []const aws.map.StringMapEntry = null,

    /// Token to retrieve the next set of results. For example, if your call to
    /// ListConfigurations returned 100 items, but you set
    /// `ListConfigurationsRequest$maxResults` to 10, you received a set of 10
    /// results
    /// along with this token. Use this token in the next query to retrieve the next
    /// set of
    /// 10.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .configurations = "configurations",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConfigurationsInput, options: CallOptions) !ListConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "discovery", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("discovery", "Application Discovery Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPoseidonService_V2015_11_01.ListConfigurations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConfigurationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListConfigurationsOutput, body, allocator);
}
