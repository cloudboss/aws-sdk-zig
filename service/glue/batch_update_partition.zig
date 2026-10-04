const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchUpdatePartitionRequestEntry = @import("batch_update_partition_request_entry.zig").BatchUpdatePartitionRequestEntry;
const BatchUpdatePartitionFailureEntry = @import("batch_update_partition_failure_entry.zig").BatchUpdatePartitionFailureEntry;

pub const BatchUpdatePartitionInput = struct {
    /// The ID of the catalog in which the partition is to be updated. Currently,
    /// this should be
    /// the Amazon Web Services account ID.
    catalog_id: ?[]const u8 = null,

    /// The name of the metadata database in which the partition is
    /// to be updated.
    database_name: []const u8,

    /// A list of up to 100 `BatchUpdatePartitionRequestEntry` objects to update.
    entries: []const BatchUpdatePartitionRequestEntry,

    /// The name of the metadata table in which the partition is to be updated.
    table_name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .entries = "Entries",
        .table_name = "TableName",
    };
};

pub const BatchUpdatePartitionOutput = struct {
    /// The errors encountered when trying to update the requested partitions. A
    /// list of `BatchUpdatePartitionFailureEntry` objects.
    errors: ?[]const BatchUpdatePartitionFailureEntry = null,

    pub const json_field_names = .{
        .errors = "Errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdatePartitionInput, options: CallOptions) !BatchUpdatePartitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdatePartitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.BatchUpdatePartition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdatePartitionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchUpdatePartitionOutput, body, allocator);
}
