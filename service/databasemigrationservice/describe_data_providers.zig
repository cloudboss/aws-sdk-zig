const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const DataProvider = @import("data_provider.zig").DataProvider;

pub const DescribeDataProvidersInput = struct {
    /// Filters applied to the data providers described in the form of key-value
    /// pairs.
    ///
    /// Valid filter names and values: data-provider-identifier, data provider arn
    /// or name
    filters: ?[]const Filter = null,

    /// Specifies the unique pagination token that makes it possible to display the
    /// next page of results.
    /// If this parameter is specified, the response includes only records beyond
    /// the marker, up to the
    /// value specified by `MaxRecords`.
    ///
    /// If `Marker` is returned by a previous response, there are more results
    /// available.
    /// The value of `Marker` is a unique pagination token for each page. To
    /// retrieve the next page,
    /// make the call again using the returned token and keeping all other arguments
    /// unchanged.
    marker: ?[]const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than
    /// the specified `MaxRecords` value, DMS includes a pagination token
    /// in the response so that you can retrieve the remaining results.
    max_records: ?i32 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .marker = "Marker",
        .max_records = "MaxRecords",
    };
};

pub const DescribeDataProvidersOutput = struct {
    /// A description of data providers.
    data_providers: ?[]const DataProvider = null,

    /// Specifies the unique pagination token that makes it possible to display the
    /// next page of results.
    /// If this parameter is specified, the response includes only records beyond
    /// the marker, up to the
    /// value specified by `MaxRecords`.
    ///
    /// If `Marker` is returned by a previous response, there are more results
    /// available.
    /// The value of `Marker` is a unique pagination token for each page. To
    /// retrieve the next page,
    /// make the call again using the returned token and keeping all other arguments
    /// unchanged.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_providers = "DataProviders",
        .marker = "Marker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDataProvidersInput, options: CallOptions) !DescribeDataProvidersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDataProvidersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.DescribeDataProviders");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDataProvidersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDataProvidersOutput, body, allocator);
}
