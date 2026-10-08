const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PartitionIndex = @import("partition_index.zig").PartitionIndex;

pub const CreatePartitionIndexInput = struct {
    /// The catalog ID where the table resides.
    catalog_id: ?[]const u8 = null,

    /// Specifies the name of a database in which you want to create a partition
    /// index.
    database_name: []const u8,

    /// Specifies a `PartitionIndex` structure to create a partition index in an
    /// existing table.
    partition_index: PartitionIndex,

    /// Specifies the name of a table in which you want to create a partition index.
    table_name: []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .partition_index = "PartitionIndex",
        .table_name = "TableName",
    };
};

pub const CreatePartitionIndexOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePartitionIndexInput, options: CallOptions) !CreatePartitionIndexOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePartitionIndexInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreatePartitionIndex");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePartitionIndexOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
