const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OpenTableFormatInput = @import("open_table_format_input.zig").OpenTableFormatInput;
const PartitionIndex = @import("partition_index.zig").PartitionIndex;
const TableInput = @import("table_input.zig").TableInput;

pub const CreateTableInput = struct {
    /// The ID of the Data Catalog in which to create the `Table`.
    /// If none is supplied, the Amazon Web Services account ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// The catalog database in which to create the new table. For Hive
    /// compatibility, this name is entirely lowercase.
    database_name: []const u8,

    /// The unique identifier for the table within the specified database that will
    /// be
    /// created in the Glue Data Catalog.
    name: ?[]const u8 = null,

    /// Specifies an `OpenTableFormatInput` structure when creating an open format
    /// table.
    open_table_format_input: ?OpenTableFormatInput = null,

    /// A list of partition indexes, `PartitionIndex` structures, to create in the
    /// table.
    partition_indexes: ?[]const PartitionIndex = null,

    /// The `TableInput` object that defines the metadata table
    /// to create in the catalog.
    table_input: ?TableInput = null,

    /// The ID of the transaction.
    transaction_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .name = "Name",
        .open_table_format_input = "OpenTableFormatInput",
        .partition_indexes = "PartitionIndexes",
        .table_input = "TableInput",
        .transaction_id = "TransactionId",
    };
};

pub const CreateTableOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTableInput, options: CallOptions) !CreateTableOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTableInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTableOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
