const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DirectQueryDataSourceType = @import("direct_query_data_source_type.zig").DirectQueryDataSourceType;
const Tag = @import("tag.zig").Tag;

pub const AddDirectQueryDataSourceInput = struct {
    /// An optional IAM access policy document that defines the permissions for
    /// accessing the data source.
    /// The policy document must be in valid JSON format and follow IAM policy
    /// syntax.
    data_source_access_policy: ?[]const u8 = null,

    /// A unique, user-defined label to identify the data source within your
    /// OpenSearch
    /// Service environment.
    data_source_name: []const u8,

    /// The supported Amazon Web Services service that you want to use as the source
    /// for
    /// direct queries in OpenSearch Service.
    data_source_type: DirectQueryDataSourceType,

    /// An optional text field for providing additional context and details about
    /// the data
    /// source.
    description: ?[]const u8 = null,

    /// An optional list of Amazon Resource Names (ARNs) for the OpenSearch
    /// collections that are
    /// associated with the direct query data source. This field is required for
    /// CloudWatchLogs
    /// and SecurityLake datasource types.
    open_search_arns: ?[]const []const u8 = null,

    tag_list: ?[]const Tag = null,

    pub const json_field_names = .{
        .data_source_access_policy = "DataSourceAccessPolicy",
        .data_source_name = "DataSourceName",
        .data_source_type = "DataSourceType",
        .description = "Description",
        .open_search_arns = "OpenSearchArns",
        .tag_list = "TagList",
    };
};

pub const AddDirectQueryDataSourceOutput = struct {
    /// The unique, system-generated identifier that represents the data source.
    data_source_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_source_arn = "DataSourceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddDirectQueryDataSourceInput, options: CallOptions) !AddDirectQueryDataSourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AddDirectQueryDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/opensearch/directQueryDataSource";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.data_source_access_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataSourceAccessPolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DataSourceName\":");
    try aws.json.writeValue(@TypeOf(input.data_source_name), input.data_source_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DataSourceType\":");
    try aws.json.writeValue(@TypeOf(input.data_source_type), input.data_source_type, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.open_search_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OpenSearchArns\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tag_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TagList\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddDirectQueryDataSourceOutput {
    const result: AddDirectQueryDataSourceOutput = try aws.json.parseJsonObject(
        AddDirectQueryDataSourceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
