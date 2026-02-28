const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCloudVmClusterInput, options: Options) !CreateCloudVmClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "odb");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateCloudVmClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("odb", "odb", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "Odb.CreateCloudVmCluster");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateCloudVmClusterOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateCloudVmClusterOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
