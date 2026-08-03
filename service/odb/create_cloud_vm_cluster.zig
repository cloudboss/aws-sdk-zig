const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const DataCollectionOptions = @import("data_collection_options.zig").DataCollectionOptions;
const LicenseModel = @import("license_model.zig").LicenseModel;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const CreateCloudVmClusterInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you don't specify a client token, the Amazon
    /// Web Services SDK automatically generates a client token and uses it for the
    /// request to ensure idempotency. The client token is valid for up to 24 hours
    /// after it's first used.
    client_token: ?[]const u8 = null,

    /// The unique identifier of the Exadata infrastructure for this VM cluster.
    cloud_exadata_infrastructure_id: []const u8,

    /// A name for the Grid Infrastructure cluster. The name isn't case sensitive.
    cluster_name: ?[]const u8 = null,

    /// The number of CPU cores to enable on the VM cluster.
    cpu_core_count: i32,

    /// The set of preferences for the various diagnostic collection options for the
    /// VM cluster.
    data_collection_options: ?DataCollectionOptions = null,

    /// The size of the data disk group, in terabytes (TBs), to allocate for the VM
    /// cluster.
    data_storage_size_in_t_bs: ?f64 = null,

    /// The amount of local node storage, in gigabytes (GBs), to allocate for the VM
    /// cluster.
    db_node_storage_size_in_g_bs: ?i32 = null,

    /// The list of database servers for the VM cluster.
    db_servers: ?[]const []const u8 = null,

    /// A user-friendly name for the VM cluster.
    display_name: []const u8,

    /// A valid software version of Oracle Grid Infrastructure (GI). To get the list
    /// of valid values, use the `ListGiVersions` operation and specify the shape of
    /// the Exadata infrastructure.
    ///
    /// Example: `19.0.0.0`
    gi_version: []const u8,

    /// The host name for the VM cluster.
    ///
    /// Constraints:
    ///
    /// * Can't be "localhost" or "hostname".
    /// * Can't contain "-version".
    /// * The maximum length of the combined hostname and domain is 63 characters.
    /// * The hostname must be unique within the subnet.
    hostname: []const u8,

    /// Specifies whether to enable database backups to local Exadata storage for
    /// the VM cluster.
    is_local_backup_enabled: ?bool = null,

    /// Specifies whether to create a sparse disk group for the VM cluster.
    is_sparse_diskgroup_enabled: ?bool = null,

    /// The Oracle license model to apply to the VM cluster.
    ///
    /// Default: `LICENSE_INCLUDED`
    license_model: ?LicenseModel = null,

    /// The amount of memory, in gigabytes (GBs), to allocate for the VM cluster.
    memory_size_in_g_bs: ?i32 = null,

    /// The unique identifier of the ODB network for the VM cluster.
    odb_network_id: []const u8,

    /// The port number for TCP connections to the single client access name (SCAN)
    /// listener.
    ///
    /// Valid values: `1024–8999` with the following exceptions: `2484`, `6100`,
    /// `6200`, `7060`, `7070`, `7085`, and `7879`
    ///
    /// Default: `1521`
    scan_listener_port_tcp: ?i32 = null,

    /// The public key portion of one or more key pairs used for SSH access to the
    /// VM cluster.
    ssh_public_keys: []const []const u8,

    /// The version of the operating system of the image for the VM cluster.
    system_version: ?[]const u8 = null,

    /// The list of resource tags to apply to the VM cluster.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The time zone for the VM cluster. For a list of valid values for time zone,
    /// you can check the options in the console.
    ///
    /// Default: UTC
    time_zone: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .cloud_exadata_infrastructure_id = "cloudExadataInfrastructureId",
        .cluster_name = "clusterName",
        .cpu_core_count = "cpuCoreCount",
        .data_collection_options = "dataCollectionOptions",
        .data_storage_size_in_t_bs = "dataStorageSizeInTBs",
        .db_node_storage_size_in_g_bs = "dbNodeStorageSizeInGBs",
        .db_servers = "dbServers",
        .display_name = "displayName",
        .gi_version = "giVersion",
        .hostname = "hostname",
        .is_local_backup_enabled = "isLocalBackupEnabled",
        .is_sparse_diskgroup_enabled = "isSparseDiskgroupEnabled",
        .license_model = "licenseModel",
        .memory_size_in_g_bs = "memorySizeInGBs",
        .odb_network_id = "odbNetworkId",
        .scan_listener_port_tcp = "scanListenerPortTcp",
        .ssh_public_keys = "sshPublicKeys",
        .system_version = "systemVersion",
        .tags = "tags",
        .time_zone = "timeZone",
    };
};

pub const CreateCloudVmClusterOutput = struct {
    /// The unique identifier for the VM cluster.
    cloud_vm_cluster_id: []const u8,

    /// The user-friendly name for the VM cluster.
    display_name: ?[]const u8 = null,

    /// The current status of the VM cluster.
    status: ?ResourceStatus = null,

    /// Additional information about the status of the VM cluster.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_vm_cluster_id = "cloudVmClusterId",
        .display_name = "displayName",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCloudVmClusterInput, options: CallOptions) !CreateCloudVmClusterOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCloudVmClusterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Odb.CreateCloudVmCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCloudVmClusterOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateCloudVmClusterOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?errors.InternalServerException = aws.json.parseJsonObject(errors.InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
