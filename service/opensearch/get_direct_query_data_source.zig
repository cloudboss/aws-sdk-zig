const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DirectQueryDataSourceType = @import("direct_query_data_source_type.zig").DirectQueryDataSourceType;

pub const GetDirectQueryDataSourceInput = struct {
    /// A unique, user-defined label that identifies the data source within your
    /// OpenSearch Service
    /// environment.
    data_source_name: []const u8,

    pub const json_field_names = .{
        .data_source_name = "DataSourceName",
    };
};

pub const GetDirectQueryDataSourceOutput = struct {
    /// The IAM access policy document that defines the permissions for accessing
    /// the direct query data source. Returns the current policy configuration in
    /// JSON format, or null if no custom policy is configured.
    data_source_access_policy: ?[]const u8 = null,

    /// The unique, system-generated identifier that represents the data source.
    data_source_arn: ?[]const u8 = null,

    /// A unique, user-defined label to identify the data source within your
    /// OpenSearch Service
    /// environment.
    data_source_name: ?[]const u8 = null,

    /// The supported Amazon Web Services service that is used as the source for
    /// direct queries in
    /// OpenSearch Service.
    data_source_type: ?DirectQueryDataSourceType = null,

    /// A description that provides additional context and details about the data
    /// source.
    description: ?[]const u8 = null,

    /// A list of Amazon Resource Names (ARNs) for the OpenSearch collections that
    /// are associated
    /// with the direct query data source.
    open_search_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .data_source_access_policy = "DataSourceAccessPolicy",
        .data_source_arn = "DataSourceArn",
        .data_source_name = "DataSourceName",
        .data_source_type = "DataSourceType",
        .description = "Description",
        .open_search_arns = "OpenSearchArns",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDirectQueryDataSourceInput, options: CallOptions) !GetDirectQueryDataSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDirectQueryDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/directQueryDataSource/");
    try path_buf.appendSlice(allocator, input.data_source_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDirectQueryDataSourceOutput {
    var result: GetDirectQueryDataSourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDirectQueryDataSourceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
