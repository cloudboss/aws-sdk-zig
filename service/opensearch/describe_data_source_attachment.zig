const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceAttachmentStatus = @import("data_source_attachment_status.zig").DataSourceAttachmentStatus;

pub const DescribeDataSourceAttachmentInput = struct {
    data_source_arn: []const u8,

    /// The unique identifier or name of the OpenSearch application.
    id: []const u8,

    pub const json_field_names = .{
        .data_source_arn = "dataSourceArn",
        .id = "id",
    };
};

pub const DescribeDataSourceAttachmentOutput = struct {
    arn: ?[]const u8 = null,

    /// The unique identifier assigned to the data source attachment.
    attachment_id: ?[]const u8 = null,

    data_source_arn: ?[]const u8 = null,

    /// The unique identifier of the OpenSearch application.
    id: ?[]const u8 = null,

    /// The status of the data source attachment. Valid values are `PENDING`,
    /// `ATTACHED`, and `FAILED`.
    status: ?DataSourceAttachmentStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .attachment_id = "attachmentId",
        .data_source_arn = "dataSourceArn",
        .id = "id",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDataSourceAttachmentInput, options: CallOptions) !DescribeDataSourceAttachmentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDataSourceAttachmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/application/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/describeDataSourceAttachment");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dataSourceArn\":");
    try aws.json.writeValue(@TypeOf(input.data_source_arn), input.data_source_arn, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDataSourceAttachmentOutput {
    const result: DescribeDataSourceAttachmentOutput = try aws.json.parseJsonObject(
        DescribeDataSourceAttachmentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
