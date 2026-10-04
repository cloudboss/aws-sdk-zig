const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateTableMetadataLocationInput = struct {
    /// The new metadata location for the table.
    metadata_location: []const u8,

    /// The name of the table.
    name: []const u8,

    /// The namespace of the table.
    namespace: []const u8,

    /// The Amazon Resource Name (ARN) of the table bucket.
    table_bucket_arn: []const u8,

    /// The version token of the table.
    version_token: []const u8,

    pub const json_field_names = .{
        .metadata_location = "metadataLocation",
        .name = "name",
        .namespace = "namespace",
        .table_bucket_arn = "tableBucketARN",
        .version_token = "versionToken",
    };
};

pub const UpdateTableMetadataLocationOutput = struct {
    /// The metadata location of the table.
    metadata_location: []const u8,

    /// The name of the table.
    name: []const u8,

    /// The namespace the table is associated with.
    namespace: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the table.
    table_arn: []const u8,

    /// The version token of the table.
    version_token: []const u8,

    pub const json_field_names = .{
        .metadata_location = "metadataLocation",
        .name = "name",
        .namespace = "namespace",
        .table_arn = "tableARN",
        .version_token = "versionToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTableMetadataLocationInput, options: CallOptions) !UpdateTableMetadataLocationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3tables", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTableMetadataLocationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3tables", "S3Tables", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/tables/");
    try path_buf.appendSlice(allocator, input.table_bucket_arn);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.namespace);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.name);
    try path_buf.appendSlice(allocator, "/metadata-location");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"metadataLocation\":");
    try aws.json.writeValue(@TypeOf(input.metadata_location), input.metadata_location, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"versionToken\":");
    try aws.json.writeValue(@TypeOf(input.version_token), input.version_token, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTableMetadataLocationOutput {
    var result: UpdateTableMetadataLocationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateTableMetadataLocationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
