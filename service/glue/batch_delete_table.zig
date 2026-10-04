const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableError = @import("table_error.zig").TableError;

pub const BatchDeleteTableInput = struct {
    /// The ID of the Data Catalog where the table resides. If none is provided, the
    /// Amazon Web Services account
    /// ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// The name of the catalog database in which the tables to delete reside. For
    /// Hive
    /// compatibility, this name is entirely lowercase.
    database_name: []const u8,

    /// A list of the table to delete.
    tables_to_delete: []const []const u8,

    /// The transaction ID at which to delete the table contents.
    transaction_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .tables_to_delete = "TablesToDelete",
        .transaction_id = "TransactionId",
    };
};

pub const BatchDeleteTableOutput = struct {
    /// A list of errors encountered in attempting to delete the specified tables.
    errors: ?[]const TableError = null,

    pub const json_field_names = .{
        .errors = "Errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteTableInput, options: CallOptions) !BatchDeleteTableOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteTableInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.BatchDeleteTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteTableOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchDeleteTableOutput, body, allocator);
}
