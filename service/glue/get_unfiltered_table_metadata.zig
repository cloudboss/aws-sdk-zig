const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditContext = @import("audit_context.zig").AuditContext;
const Permission = @import("permission.zig").Permission;
const QuerySessionContext = @import("query_session_context.zig").QuerySessionContext;
const SupportedDialect = @import("supported_dialect.zig").SupportedDialect;
const PermissionType = @import("permission_type.zig").PermissionType;
const ColumnRowFilter = @import("column_row_filter.zig").ColumnRowFilter;
const Table = @import("table.zig").Table;

pub const GetUnfilteredTableMetadataInput = struct {
    /// A structure containing Lake Formation audit context information.
    audit_context: ?AuditContext = null,

    /// The catalog ID where the table resides.
    catalog_id: []const u8,

    /// (Required) Specifies the name of a database that contains the table.
    database_name: []const u8,

    /// (Required) Specifies the name of a table for which you are requesting
    /// metadata.
    name: []const u8,

    /// The resource ARN of the view.
    parent_resource_arn: ?[]const u8 = null,

    /// The Lake Formation data permissions of the caller on the table. Used to
    /// authorize the call when no view context is found.
    permissions: ?[]const Permission = null,

    /// A structure used as a protocol between query engines and Lake Formation or
    /// Glue. Contains both a Lake Formation generated authorization identifier and
    /// information from the request's authorization context.
    query_session_context: ?QuerySessionContext = null,

    /// Specified only if the base tables belong to a different Amazon Web Services
    /// Region.
    region: ?[]const u8 = null,

    /// The resource ARN of the root view in a chain of nested views.
    root_resource_arn: ?[]const u8 = null,

    /// A structure specifying the dialect and dialect version used by the query
    /// engine.
    supported_dialect: ?SupportedDialect = null,

    /// Indicates the level of filtering a third-party analytical engine is capable
    /// of enforcing when calling the `GetUnfilteredTableMetadata` API operation.
    /// Accepted values are:
    ///
    /// * `COLUMN_PERMISSION` - Column permissions ensure that users can access only
    ///   specific columns in the table. If there are particular columns contain
    ///   sensitive data, data lake administrators can define column filters that
    ///   exclude access to specific columns.
    ///
    /// * `CELL_FILTER_PERMISSION` - Cell-level filtering combines column filtering
    ///   (include or exclude columns) and row filter expressions to restrict access
    ///   to individual elements in the table.
    ///
    /// * `NESTED_PERMISSION` - Nested permissions combines cell-level filtering and
    ///   nested column filtering to restrict access to columns and/or nested
    ///   columns in specific rows based on row filter expressions.
    ///
    /// * `NESTED_CELL_PERMISSION` - Nested cell permissions combines nested
    ///   permission with nested cell-level filtering. This allows different subsets
    ///   of nested columns to be restricted based on an array of row filter
    ///   expressions.
    ///
    /// Note: Each of these permission types follows a hierarchical order where each
    /// subsequent permission type includes all permission of the previous type.
    ///
    /// Important: If you provide a supported permission type that doesn't match the
    /// user's level of permissions on the table, then Lake Formation raises an
    /// exception. For example, if the third-party engine calling the
    /// `GetUnfilteredTableMetadata` operation can enforce only column-level
    /// filtering, and the user has nested cell filtering applied on the table, Lake
    /// Formation throws an exception, and will not return unfiltered table metadata
    /// and data access credentials.
    supported_permission_types: []const PermissionType,

    pub const json_field_names = .{
        .audit_context = "AuditContext",
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .name = "Name",
        .parent_resource_arn = "ParentResourceArn",
        .permissions = "Permissions",
        .query_session_context = "QuerySessionContext",
        .region = "Region",
        .root_resource_arn = "RootResourceArn",
        .supported_dialect = "SupportedDialect",
        .supported_permission_types = "SupportedPermissionTypes",
    };
};

pub const GetUnfilteredTableMetadataOutput = struct {
    /// A list of column names that the user has been granted access to.
    authorized_columns: ?[]const []const u8 = null,

    /// A list of column row filters.
    cell_filters: ?[]const ColumnRowFilter = null,

    /// Indicates if a table is a materialized view.
    is_materialized_view: ?bool = null,

    /// Specifies whether the view supports the SQL dialects of one or more
    /// different query engines and can therefore be read by those engines.
    is_multi_dialect_view: ?bool = null,

    /// A flag that instructs the engine not to push user-provided operations into
    /// the logical plan of the view during query planning. However, if set this
    /// flag does not guarantee that the engine will comply. Refer to the engine's
    /// documentation to understand the guarantees provided, if any.
    is_protected: ?bool = null,

    /// A Boolean value that indicates whether the partition location is registered
    /// with Lake Formation.
    is_registered_with_lake_formation: ?bool = null,

    /// The Lake Formation data permissions of the caller on the table. Used to
    /// authorize the call when no view context is found.
    permissions: ?[]const Permission = null,

    /// A cryptographically generated query identifier generated by Glue or Lake
    /// Formation.
    query_authorization_id: ?[]const u8 = null,

    /// The resource ARN of the parent resource extracted from the request.
    resource_arn: ?[]const u8 = null,

    /// The filter that applies to the table. For example when applying the filter
    /// in SQL, it would go in the `WHERE` clause and can be evaluated by using an
    /// `AND` operator with any other predicates applied by the user querying the
    /// table.
    row_filter: ?[]const u8 = null,

    /// A Table object containing the table metadata.
    table: ?Table = null,

    pub const json_field_names = .{
        .authorized_columns = "AuthorizedColumns",
        .cell_filters = "CellFilters",
        .is_materialized_view = "IsMaterializedView",
        .is_multi_dialect_view = "IsMultiDialectView",
        .is_protected = "IsProtected",
        .is_registered_with_lake_formation = "IsRegisteredWithLakeFormation",
        .permissions = "Permissions",
        .query_authorization_id = "QueryAuthorizationId",
        .resource_arn = "ResourceArn",
        .row_filter = "RowFilter",
        .table = "Table",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUnfilteredTableMetadataInput, options: CallOptions) !GetUnfilteredTableMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUnfilteredTableMetadataInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetUnfilteredTableMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUnfilteredTableMetadataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetUnfilteredTableMetadataOutput, body, allocator);
}
