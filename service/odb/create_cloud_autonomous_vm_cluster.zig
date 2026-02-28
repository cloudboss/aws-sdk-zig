const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const LicenseModel = @import("license_model.zig").LicenseModel;
const MaintenanceWindow = @import("maintenance_window.zig").MaintenanceWindow;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const CreateCloudAutonomousVmClusterInput = struct {
    /// The data disk group size to be allocated for Autonomous Databases, in
    /// terabytes (TB).
    autonomous_data_storage_size_in_t_bs: f64,

    /// A client-provided token to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The unique identifier of the Exadata infrastructure where the VM cluster
    /// will be created.
    cloud_exadata_infrastructure_id: []const u8,

    /// The number of CPU cores to be enabled per VM cluster node.
    cpu_core_count_per_node: i32,

    /// The list of database servers to be used for the Autonomous VM cluster.
    db_servers: ?[]const []const u8 = null,

    /// A user-provided description of the Autonomous VM cluster.
    description: ?[]const u8 = null,

    /// The display name for the Autonomous VM cluster. The name does not need to be
    /// unique.
    display_name: []const u8,

    /// Specifies whether to enable mutual TLS (mTLS) authentication for the
    /// Autonomous VM cluster.
    is_mtls_enabled_vm_cluster: ?bool = null,

    /// The Oracle license model to apply to the Autonomous VM cluster.
    license_model: ?LicenseModel = null,

    /// The scheduling details for the maintenance window. Patching and system
    /// updates take place during the maintenance window.
    maintenance_window: ?MaintenanceWindow = null,

    /// The amount of memory to be allocated per OCPU, in GB.
    memory_per_oracle_compute_unit_in_g_bs: i32,

    /// The unique identifier of the ODB network to be used for the VM cluster.
    odb_network_id: []const u8,

    /// The SCAN listener port for non-TLS (TCP) protocol.
    scan_listener_port_non_tls: ?i32 = null,

    /// The SCAN listener port for TLS (TCP) protocol.
    scan_listener_port_tls: ?i32 = null,

    /// Free-form tags for this resource. Each tag is a key-value pair with no
    /// predefined name, type, or namespace.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The time zone to use for the Autonomous VM cluster.
    time_zone: ?[]const u8 = null,

    /// The total number of Autonomous CDBs that you can create in the Autonomous VM
    /// cluster.
    total_container_databases: i32,

    pub const json_field_names = .{
        .autonomous_data_storage_size_in_t_bs = "autonomousDataStorageSizeInTBs",
        .client_token = "clientToken",
        .cloud_exadata_infrastructure_id = "cloudExadataInfrastructureId",
        .cpu_core_count_per_node = "cpuCoreCountPerNode",
        .db_servers = "dbServers",
        .description = "description",
        .display_name = "displayName",
        .is_mtls_enabled_vm_cluster = "isMtlsEnabledVmCluster",
        .license_model = "licenseModel",
        .maintenance_window = "maintenanceWindow",
        .memory_per_oracle_compute_unit_in_g_bs = "memoryPerOracleComputeUnitInGBs",
        .odb_network_id = "odbNetworkId",
        .scan_listener_port_non_tls = "scanListenerPortNonTls",
        .scan_listener_port_tls = "scanListenerPortTls",
        .tags = "tags",
        .time_zone = "timeZone",
        .total_container_databases = "totalContainerDatabases",
    };
};

pub const CreateCloudAutonomousVmClusterOutput = struct {
    /// The unique identifier of the created Autonomous VM cluster.
    cloud_autonomous_vm_cluster_id: []const u8,

    /// The display name of the created Autonomous VM cluster.
    display_name: ?[]const u8 = null,

    /// The current status of the Autonomous VM cluster creation process.
    status: ?ResourceStatus = null,

    /// Additional information about the current status of the Autonomous VM cluster
    /// creation process, if applicable.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_autonomous_vm_cluster_id = "cloudAutonomousVmClusterId",
        .display_name = "displayName",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCloudAutonomousVmClusterInput, options: Options) !CreateCloudAutonomousVmClusterOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateCloudAutonomousVmClusterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "Odb.CreateCloudAutonomousVmCluster");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateCloudAutonomousVmClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCloudAutonomousVmClusterOutput, body, alloc);
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
