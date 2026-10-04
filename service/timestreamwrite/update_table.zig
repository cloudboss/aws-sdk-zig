const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MagneticStoreWriteProperties = @import("magnetic_store_write_properties.zig").MagneticStoreWriteProperties;
const RetentionProperties = @import("retention_properties.zig").RetentionProperties;
const Schema = @import("schema.zig").Schema;
const Table = @import("table.zig").Table;

pub const UpdateTableInput = struct {
    /// The name of the Timestream database.
    database_name: []const u8,

    /// Contains properties to set on the table when enabling magnetic store writes.
    magnetic_store_write_properties: ?MagneticStoreWriteProperties = null,

    /// The retention duration of the memory store and the magnetic store.
    retention_properties: ?RetentionProperties = null,

    /// The schema of the table.
    schema: ?Schema = null,

    /// The name of the Timestream table.
    table_name: []const u8,

    pub const json_field_names = .{
        .database_name = "DatabaseName",
        .magnetic_store_write_properties = "MagneticStoreWriteProperties",
        .retention_properties = "RetentionProperties",
        .schema = "Schema",
        .table_name = "TableName",
    };
};

pub const UpdateTableOutput = struct {
    /// The updated Timestream table.
    table: ?Table = null,

    pub const json_field_names = .{
        .table = "Table",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTableInput, options: CallOptions) !UpdateTableOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ingest.timestream", "Timestream Write", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.UpdateTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTableOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateTableOutput, body, allocator);
}
