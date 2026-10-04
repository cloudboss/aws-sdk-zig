const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditContext = @import("audit_context.zig").AuditContext;
const PartitionValueList = @import("partition_value_list.zig").PartitionValueList;
const QuerySessionContext = @import("query_session_context.zig").QuerySessionContext;
const Partition = @import("partition.zig").Partition;

pub const BatchGetPartitionInput = struct {
    audit_context: ?AuditContext = null,

    /// The ID of the Data Catalog where the partitions in question reside.
    /// If none is supplied, the Amazon Web Services account ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// The name of the catalog database where the partitions reside.
    database_name: []const u8,

    /// A list of partition values identifying the partitions to retrieve.
    partitions_to_get: []const PartitionValueList,

    query_session_context: ?QuerySessionContext = null,

    /// The name of the partitions' table.
    table_name: []const u8,

    pub const json_field_names = .{
        .audit_context = "AuditContext",
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .partitions_to_get = "PartitionsToGet",
        .query_session_context = "QuerySessionContext",
        .table_name = "TableName",
    };
};

pub const BatchGetPartitionOutput = struct {
    /// A list of the requested partitions.
    partitions: ?[]const Partition = null,

    /// A list of the partition values in the request for which partitions were not
    /// returned.
    unprocessed_keys: ?[]const PartitionValueList = null,

    pub const json_field_names = .{
        .partitions = "Partitions",
        .unprocessed_keys = "UnprocessedKeys",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetPartitionInput, options: CallOptions) !BatchGetPartitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetPartitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.BatchGetPartition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetPartitionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetPartitionOutput, body, allocator);
}
