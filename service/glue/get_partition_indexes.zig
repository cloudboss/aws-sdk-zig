const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PartitionIndexDescriptor = @import("partition_index_descriptor.zig").PartitionIndexDescriptor;

pub const GetPartitionIndexesInput = struct {
    /// The catalog ID where the table resides.
    catalog_id: ?[]const u8 = null,

    /// Specifies the name of a database from which you want to retrieve partition
    /// indexes.
    database_name: []const u8,

    /// A continuation token, included if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// Specifies the name of a table for which you want to retrieve the partition
    /// indexes.
    table_name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .next_token = "NextToken",
        .table_name = "TableName",
    };
};

pub const GetPartitionIndexesOutput = struct {
    /// A continuation token, present if the current list segment is not the last.
    next_token: ?[]const u8 = null,

    /// A list of index descriptors.
    partition_index_descriptor_list: ?[]const PartitionIndexDescriptor = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .partition_index_descriptor_list = "PartitionIndexDescriptorList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPartitionIndexesInput, options: CallOptions) !GetPartitionIndexesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPartitionIndexesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetPartitionIndexes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPartitionIndexesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPartitionIndexesOutput, body, allocator);
}
