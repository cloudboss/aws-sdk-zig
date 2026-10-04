const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceCredentials = @import("data_source_credentials.zig").DataSourceCredentials;
const DataSourceParameters = @import("data_source_parameters.zig").DataSourceParameters;
const SslProperties = @import("ssl_properties.zig").SslProperties;
const VpcConnectionProperties = @import("vpc_connection_properties.zig").VpcConnectionProperties;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const UpdateDataSourceInput = struct {
    /// The Amazon Web Services account ID.
    aws_account_id: []const u8,

    /// The credentials that Amazon Quick Sight that uses to connect to your
    /// underlying source.
    /// Currently, only credentials based on user name and password are supported.
    credentials: ?DataSourceCredentials = null,

    /// The ID of the data source. This ID is unique per Amazon Web Services Region
    /// for each
    /// Amazon Web Services account.
    data_source_id: []const u8,

    /// The parameters that Amazon Quick Sight uses to connect to your underlying
    /// source.
    data_source_parameters: ?DataSourceParameters = null,

    /// A display name for the data source.
    name: []const u8,

    /// Secure Socket Layer (SSL) properties that apply when Amazon Quick Sight
    /// connects to
    /// your underlying source.
    ssl_properties: ?SslProperties = null,

    /// Use this parameter only when you want Amazon Quick Sight to use a VPC
    /// connection when
    /// connecting to your underlying source.
    vpc_connection_properties: ?VpcConnectionProperties = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .credentials = "Credentials",
        .data_source_id = "DataSourceId",
        .data_source_parameters = "DataSourceParameters",
        .name = "Name",
        .ssl_properties = "SslProperties",
        .vpc_connection_properties = "VpcConnectionProperties",
    };
};

pub const UpdateDataSourceOutput = struct {
    /// The Amazon Resource Name (ARN) of the data source.
    arn: ?[]const u8 = null,

    /// The ID of the data source. This ID is unique per Amazon Web Services Region
    /// for each
    /// Amazon Web Services account.
    data_source_id: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    /// The update status of the data source's last update.
    update_status: ?ResourceStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .data_source_id = "DataSourceId",
        .request_id = "RequestId",
        .status = "Status",
        .update_status = "UpdateStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataSourceInput, options: CallOptions) !UpdateDataSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/data-sources/");
    try path_buf.appendSlice(allocator, input.data_source_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.credentials) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Credentials\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_source_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataSourceParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.ssl_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SslProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_connection_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VpcConnectionProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDataSourceOutput {
    var result: UpdateDataSourceOutput = try aws.json.parseJsonObject(
        UpdateDataSourceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
