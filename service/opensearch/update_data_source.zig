const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceType = @import("data_source_type.zig").DataSourceType;
const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;

pub const UpdateDataSourceInput = struct {
    /// The type of data source.
    data_source_type: DataSourceType,

    /// A new description of the data source.
    description: ?[]const u8 = null,

    /// The name of the domain.
    domain_name: []const u8,

    /// The name of the data source to modify.
    name: []const u8,

    /// The status of the data source update.
    status: ?DataSourceStatus = null,

    pub const json_field_names = .{
        .data_source_type = "DataSourceType",
        .description = "Description",
        .domain_name = "DomainName",
        .name = "Name",
        .status = "Status",
    };
};

pub const UpdateDataSourceOutput = struct {
    /// A message associated with the updated data source.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDataSourceInput, options: CallOptions) !UpdateDataSourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDataSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/dataSource/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Status\":");
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
    var result: UpdateDataSourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateDataSourceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
