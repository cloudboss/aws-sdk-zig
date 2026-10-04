const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const CreateExascaleDbStorageVaultInput = struct {
    /// The additional flash cache percentage for the Exascale storage vault.
    additional_flash_cache_in_percent: ?i32 = null,

    /// The autoscale limit in gigabytes (GB) for the Exascale storage vault.
    autoscale_limit_in_g_bs: ?i32 = null,

    /// The Availability Zone for the Exascale storage vault.
    availability_zone: ?[]const u8 = null,

    /// The Availability Zone ID for the Exascale storage vault.
    availability_zone_id: ?[]const u8 = null,

    /// A unique, case-sensitive identifier that you provide to ensure that the
    /// operation completes no more than one time. If you submit the same request
    /// twice with the same client token, the service ignores the second request and
    /// returns the result of the first. If you don't specify a client token, the
    /// AWS SDK automatically generates one. The client token is valid for up to 24
    /// hours after it's first used.
    client_token: ?[]const u8 = null,

    /// A description of the Exascale storage vault.
    description: ?[]const u8 = null,

    /// A user-friendly name for the Exascale storage vault.
    display_name: []const u8,

    /// The total size of the high-capacity database storage, in gigabytes (GB), for
    /// the Exascale storage vault.
    high_capacity_database_storage_total_size_in_g_bs: i32,

    /// Specifies whether autoscaling is enabled for the Exascale storage vault.
    is_autoscale_enabled: ?bool = null,

    /// The list of resource tags to apply to the Exascale storage vault.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The time zone for the Exascale storage vault.
    time_zone: ?[]const u8 = null,

    pub const json_field_names = .{
        .additional_flash_cache_in_percent = "additionalFlashCacheInPercent",
        .autoscale_limit_in_g_bs = "autoscaleLimitInGBs",
        .availability_zone = "availabilityZone",
        .availability_zone_id = "availabilityZoneId",
        .client_token = "clientToken",
        .description = "description",
        .display_name = "displayName",
        .high_capacity_database_storage_total_size_in_g_bs = "highCapacityDatabaseStorageTotalSizeInGBs",
        .is_autoscale_enabled = "isAutoscaleEnabled",
        .tags = "tags",
        .time_zone = "timeZone",
    };
};

pub const CreateExascaleDbStorageVaultOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateExascaleDbStorageVaultInput, options: CallOptions) !CreateExascaleDbStorageVaultOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateExascaleDbStorageVaultInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Odb.CreateExascaleDbStorageVault");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateExascaleDbStorageVaultOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateExascaleDbStorageVaultOutput, body, allocator);
}
