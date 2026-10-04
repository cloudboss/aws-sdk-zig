const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IntegrationTablePropertiesFilter = @import("integration_table_properties_filter.zig").IntegrationTablePropertiesFilter;
const IntegrationTableProperties = @import("integration_table_properties.zig").IntegrationTableProperties;

pub const ListIntegrationTablePropertiesInput = struct {
    /// A list of filters. Supported filter keys are `SourceArn`, `TargetArn`,
    /// `SourceTableName`, and `TargetTableName`.
    filters: ?[]const IntegrationTablePropertiesFilter = null,

    /// The pagination token for the next page of results. The initial value is
    /// `null`.
    marker: ?[]const u8 = null,

    /// The maximum number of records to return in the response.
    max_records: ?i32 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .marker = "Marker",
        .max_records = "MaxRecords",
    };
};

pub const ListIntegrationTablePropertiesOutput = struct {
    /// A list of integration table properties meeting the filter criteria.
    integration_table_properties_list: ?[]const IntegrationTableProperties = null,

    /// The pagination token for the next page. Returns `null` if there are no more
    /// results.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .integration_table_properties_list = "IntegrationTablePropertiesList",
        .marker = "Marker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListIntegrationTablePropertiesInput, options: CallOptions) !ListIntegrationTablePropertiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListIntegrationTablePropertiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.ListIntegrationTableProperties");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListIntegrationTablePropertiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListIntegrationTablePropertiesOutput, body, allocator);
}
