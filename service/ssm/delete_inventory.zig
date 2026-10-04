const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InventorySchemaDeleteOption = @import("inventory_schema_delete_option.zig").InventorySchemaDeleteOption;
const InventoryDeletionSummary = @import("inventory_deletion_summary.zig").InventoryDeletionSummary;

pub const DeleteInventoryInput = struct {
    /// User-provided idempotency token.
    client_token: ?[]const u8 = null,

    /// Use this option to view a summary of the deletion request without deleting
    /// any data or the
    /// data type. This option is useful when you only want to understand what will
    /// be deleted. Once you
    /// validate that the data to be deleted is what you intend to delete, you can
    /// run the same command
    /// without specifying the `DryRun` option.
    dry_run: ?bool = null,

    /// Use the `SchemaDeleteOption` to delete a custom inventory type (schema). If
    /// you
    /// don't choose this option, the system only deletes existing inventory data
    /// associated with the
    /// custom inventory type. Choose one of the following options:
    ///
    /// DisableSchema: If you choose this option, the system ignores all inventory
    /// data for the
    /// specified version, and any earlier versions. To enable this schema again,
    /// you must call the
    /// `PutInventory` operation for a version greater than the disabled version.
    ///
    /// DeleteSchema: This option deletes the specified custom type from the
    /// Inventory service. You
    /// can recreate the schema later, if you want.
    schema_delete_option: ?InventorySchemaDeleteOption = null,

    /// The name of the custom inventory type for which you want to delete either
    /// all previously
    /// collected data or the inventory type itself.
    type_name: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .dry_run = "DryRun",
        .schema_delete_option = "SchemaDeleteOption",
        .type_name = "TypeName",
    };
};

pub const DeleteInventoryOutput = struct {
    /// Every `DeleteInventory` operation is assigned a unique ID. This option
    /// returns a
    /// unique ID. You can use this ID to query the status of a delete operation.
    /// This option is useful
    /// for ensuring that a delete operation has completed before you begin other
    /// operations.
    deletion_id: ?[]const u8 = null,

    /// A summary of the delete operation. For more information about this summary,
    /// see [Deleting custom
    /// inventory](https://docs.aws.amazon.com/systems-manager/latest/userguide/inventory-custom.html#delete-custom-inventory-summary) in the *Amazon Web Services Systems Manager User Guide*.
    deletion_summary: ?InventoryDeletionSummary = null,

    /// The name of the inventory data type specified in the request.
    type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .deletion_id = "DeletionId",
        .deletion_summary = "DeletionSummary",
        .type_name = "TypeName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteInventoryInput, options: CallOptions) !DeleteInventoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteInventoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DeleteInventory");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteInventoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteInventoryOutput, body, allocator);
}
