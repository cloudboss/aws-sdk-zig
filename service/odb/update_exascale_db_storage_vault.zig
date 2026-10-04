const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const UpdateExascaleDbStorageVaultInput = struct {
    /// The additional flash cache percentage for the Exascale storage vault.
    additional_flash_cache_in_percent: ?i32 = null,

    /// The autoscale limit in gigabytes (GB) for the Exascale storage vault.
    autoscale_limit_in_g_bs: ?i32 = null,

    /// A new description for the Exascale storage vault.
    description: ?[]const u8 = null,

    /// A new user-friendly name for the Exascale storage vault.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the Exascale storage vault to update.
    exascale_db_storage_vault_id: []const u8,

    /// The total size of the high-capacity database storage, in gigabytes (GB), for
    /// the Exascale storage vault.
    high_capacity_database_storage_total_size_in_g_bs: ?i32 = null,

    /// Specifies whether autoscaling is enabled for the Exascale storage vault.
    is_autoscale_enabled: ?bool = null,

    pub const json_field_names = .{
        .additional_flash_cache_in_percent = "additionalFlashCacheInPercent",
        .autoscale_limit_in_g_bs = "autoscaleLimitInGBs",
        .description = "description",
        .display_name = "displayName",
        .exascale_db_storage_vault_id = "exascaleDbStorageVaultId",
        .high_capacity_database_storage_total_size_in_g_bs = "highCapacityDatabaseStorageTotalSizeInGBs",
        .is_autoscale_enabled = "isAutoscaleEnabled",
    };
};

pub const UpdateExascaleDbStorageVaultOutput = struct {
    /// The user-friendly name for the Exascale storage vault.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the Exascale storage vault.
    exascale_db_storage_vault_id: []const u8,

    /// The current status of the Exascale storage vault.
    status: ?ResourceStatus = null,

    /// Additional information about the status of the Exascale storage vault.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
        .exascale_db_storage_vault_id = "exascaleDbStorageVaultId",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateExascaleDbStorageVaultInput, options: CallOptions) !UpdateExascaleDbStorageVaultOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "odb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateExascaleDbStorageVaultInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("odb", "odb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Odb.UpdateExascaleDbStorageVault");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateExascaleDbStorageVaultOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateExascaleDbStorageVaultOutput, body, allocator);
}
