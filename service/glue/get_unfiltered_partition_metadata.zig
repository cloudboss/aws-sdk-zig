const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditContext = @import("audit_context.zig").AuditContext;
const QuerySessionContext = @import("query_session_context.zig").QuerySessionContext;
const PermissionType = @import("permission_type.zig").PermissionType;
const Partition = @import("partition.zig").Partition;

pub const GetUnfilteredPartitionMetadataInput = struct {
    /// A structure containing Lake Formation audit context information.
    audit_context: ?AuditContext = null,

    /// The catalog ID where the partition resides.
    catalog_id: []const u8,

    /// (Required) Specifies the name of a database that contains the partition.
    database_name: []const u8,

    /// (Required) A list of partition key values.
    partition_values: []const []const u8,

    /// A structure used as a protocol between query engines and Lake Formation or
    /// Glue. Contains both a Lake Formation generated authorization identifier and
    /// information from the request's authorization context.
    query_session_context: ?QuerySessionContext = null,

    /// Specified only if the base tables belong to a different Amazon Web Services
    /// Region.
    region: ?[]const u8 = null,

    /// (Required) A list of supported permission types.
    supported_permission_types: []const PermissionType,

    /// (Required) Specifies the name of a table that contains the partition.
    table_name: []const u8,

    pub const json_field_names = .{
        .audit_context = "AuditContext",
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .partition_values = "PartitionValues",
        .query_session_context = "QuerySessionContext",
        .region = "Region",
        .supported_permission_types = "SupportedPermissionTypes",
        .table_name = "TableName",
    };
};

pub const GetUnfilteredPartitionMetadataOutput = struct {
    /// A list of column names that the user has been granted access to.
    authorized_columns: ?[]const []const u8 = null,

    /// A Boolean value that indicates whether the partition location is registered
    /// with Lake Formation.
    is_registered_with_lake_formation: ?bool = null,

    /// A Partition object containing the partition metadata.
    partition: ?Partition = null,

    pub const json_field_names = .{
        .authorized_columns = "AuthorizedColumns",
        .is_registered_with_lake_formation = "IsRegisteredWithLakeFormation",
        .partition = "Partition",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUnfilteredPartitionMetadataInput, options: CallOptions) !GetUnfilteredPartitionMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUnfilteredPartitionMetadataInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetUnfilteredPartitionMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUnfilteredPartitionMetadataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetUnfilteredPartitionMetadataOutput, body, allocator);
}
