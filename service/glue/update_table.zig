const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableInput = @import("table_input.zig").TableInput;
const UpdateOpenTableFormatInput = @import("update_open_table_format_input.zig").UpdateOpenTableFormatInput;
const ViewUpdateAction = @import("view_update_action.zig").ViewUpdateAction;

pub const UpdateTableInput = struct {
    /// The ID of the Data Catalog where the table resides. If none is provided, the
    /// Amazon Web Services account
    /// ID is used by default.
    catalog_id: ?[]const u8 = null,

    /// The name of the catalog database in which the table resides. For Hive
    /// compatibility, this name is entirely lowercase.
    database_name: []const u8,

    /// A flag that can be set to true to ignore matching storage descriptor and
    /// subobject matching requirements.
    force: ?bool = null,

    /// The unique identifier for the table within the specified database that will
    /// be
    /// created in the Glue Data Catalog.
    name: ?[]const u8 = null,

    /// By default, `UpdateTable` always creates an archived version of the table
    /// before updating it. However, if `skipArchive` is set to true,
    /// `UpdateTable` does not create the archived version.
    skip_archive: ?bool = null,

    /// An updated `TableInput` object to define the metadata table
    /// in the catalog.
    table_input: ?TableInput = null,

    /// The transaction ID at which to update the table contents.
    transaction_id: ?[]const u8 = null,

    /// Input parameters for updating open table format tables in GlueData Catalog,
    /// serving as a wrapper for format-specific update operations such as Apache
    /// Iceberg.
    update_open_table_format_input: ?UpdateOpenTableFormatInput = null,

    /// The version ID at which to update the table contents.
    version_id: ?[]const u8 = null,

    /// The operation to be performed when updating the view.
    view_update_action: ?ViewUpdateAction = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .database_name = "DatabaseName",
        .force = "Force",
        .name = "Name",
        .skip_archive = "SkipArchive",
        .table_input = "TableInput",
        .transaction_id = "TransactionId",
        .update_open_table_format_input = "UpdateOpenTableFormatInput",
        .version_id = "VersionId",
        .view_update_action = "ViewUpdateAction",
    };
};

pub const UpdateTableOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTableInput, options: CallOptions) !UpdateTableOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTableInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.UpdateTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTableOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
