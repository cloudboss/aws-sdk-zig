const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCloudAutonomousVmClusterInput, options: CallOptions) !CreateCloudAutonomousVmClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCloudAutonomousVmClusterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Odb.CreateCloudAutonomousVmCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCloudAutonomousVmClusterOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateCloudAutonomousVmClusterOutput, body, allocator);
}
