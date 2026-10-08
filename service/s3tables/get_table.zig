const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OpenTableFormat = @import("open_table_format.zig").OpenTableFormat;
const ManagedTableInformation = @import("managed_table_information.zig").ManagedTableInformation;
const TableType = @import("table_type.zig").TableType;

pub const GetTableInput = struct {
    /// The name of the table.
    name: ?[]const u8 = null,

    /// The name of the namespace the table is associated with.
    namespace: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the table.
    table_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the table bucket associated with the
    /// table.
    table_bucket_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .namespace = "namespace",
        .table_arn = "tableArn",
        .table_bucket_arn = "tableBucketARN",
    };
};

pub const GetTableOutput = struct {
    /// The date and time the table bucket was created at.
    created_at: i64,

    /// The ID of the account that created the table.
    created_by: []const u8,

    /// The format of the table.
    format: OpenTableFormat,

    /// The service that manages the table.
    managed_by_service: ?[]const u8 = null,

    /// If this table is managed by S3 Tables, contains additional information such
    /// as replication details.
    managed_table_information: ?ManagedTableInformation = null,

    /// The metadata location of the table.
    metadata_location: ?[]const u8 = null,

    /// The date and time the table was last modified on.
    modified_at: i64,

    /// The ID of the account that last modified the table.
    modified_by: []const u8,

    /// The name of the table.
    name: []const u8,

    /// The namespace associated with the table.
    namespace: ?[]const []const u8 = null,

    /// The unique identifier of the namespace containing this table.
    namespace_id: ?[]const u8 = null,

    /// The ID of the account that owns the table.
    owner_account_id: []const u8,

    /// The Amazon Resource Name (ARN) of the table.
    table_arn: []const u8,

    /// The unique identifier of the table bucket containing this table.
    table_bucket_id: ?[]const u8 = null,

    /// The type of the table.
    type: TableType,

    /// The version token of the table.
    version_token: []const u8,

    /// The warehouse location of the table.
    warehouse_location: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .format = "format",
        .managed_by_service = "managedByService",
        .managed_table_information = "managedTableInformation",
        .metadata_location = "metadataLocation",
        .modified_at = "modifiedAt",
        .modified_by = "modifiedBy",
        .name = "name",
        .namespace = "namespace",
        .namespace_id = "namespaceId",
        .owner_account_id = "ownerAccountId",
        .table_arn = "tableARN",
        .table_bucket_id = "tableBucketId",
        .type = "type",
        .version_token = "versionToken",
        .warehouse_location = "warehouseLocation",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTableInput, options: CallOptions) !GetTableOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3tables", "S3Tables", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/get-table";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "name=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.namespace) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "namespace=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.table_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "tableArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.table_bucket_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "tableBucketARN=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTableOutput {
    const result: GetTableOutput = try aws.json.parseJsonObject(
        GetTableOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
