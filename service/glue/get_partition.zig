const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditContext = @import("audit_context.zig").AuditContext;
const Partition = @import("partition.zig").Partition;

pub const GetPartitionInput = struct {
    audit_context: ?AuditContext = null,

    /// The ID of the Data Catalog where the partition in question resides. If none
    /// is provided,
    /// the Amazon Web Services account ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// The name of the catalog database where the partition resides.
    database_name: []const u8,

    /// The values that define the partition.
    partition_values: []const []const u8,

    /// The name of the partition's table.
    table_name: []const u8,

    pub const json_field_names = .{
        .audit_context = "AuditContext",
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .partition_values = "PartitionValues",
        .table_name = "TableName",
    };
};

pub const GetPartitionOutput = struct {
    /// The requested information, in the form of a `Partition`
    /// object.
    partition: ?Partition = null,

    pub const json_field_names = .{
        .partition = "Partition",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPartitionInput, options: CallOptions) !GetPartitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPartitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetPartition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPartitionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPartitionOutput, body, allocator);
}
