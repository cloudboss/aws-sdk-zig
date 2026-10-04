const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataCollectionOptions = @import("data_collection_options.zig").DataCollectionOptions;
const LicenseModel = @import("license_model.zig").LicenseModel;
const ShapeAttribute = @import("shape_attribute.zig").ShapeAttribute;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const CreateExadbVmClusterInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure that the
    /// operation completes no more than one time. If you submit the same request
    /// twice with the same client token, the service ignores the second request and
    /// returns the result of the first. If you don't specify a client token, the
    /// AWS SDK automatically generates one. The client token is valid for up to 24
    /// hours after it's first used.
    client_token: ?[]const u8 = null,

    /// A name for the Grid Infrastructure cluster. The name isn't case sensitive.
    cluster_name: ?[]const u8 = null,

    /// The set of preferences for the various diagnostic collection options for the
    /// Exascale VM cluster.
    data_collection_options: ?DataCollectionOptions = null,

    /// A user-friendly name for the Exascale VM cluster.
    display_name: []const u8,

    /// The number of ECPUs to enable for the Exascale VM cluster.
    enabled_ecpu_count: i32,

    /// The unique identifier of the Exascale storage vault for this Exascale VM
    /// cluster.
    exascale_db_storage_vault_id: []const u8,

    /// The Grid Infrastructure software image ID for the Exascale VM cluster.
    grid_image_id: []const u8,

    /// The host name for the Exascale VM cluster.
    hostname: []const u8,

    /// The Oracle license model to apply to the Exascale VM cluster.
    license_model: ?LicenseModel = null,

    /// The number of nodes in the Exascale VM cluster.
    node_count: i32,

    /// The unique identifier of the ODB network for the Exascale VM cluster.
    odb_network_id: []const u8,

    /// The port number for TCP connections to the Single Client Access Name (SCAN)
    /// listener.
    scan_listener_port_tcp: ?i32 = null,

    /// The port number for TCP connections with SSL to the Single Client Access
    /// Name (SCAN) listener.
    scan_listener_port_tcp_ssl: ?i32 = null,

    /// The shape of the Exascale VM cluster.
    shape: []const u8,

    /// The shape attribute for the Exascale VM cluster.
    shape_attribute: ?ShapeAttribute = null,

    /// The public key portion of one or more key pairs used for SSH access to the
    /// Exascale VM cluster.
    ssh_public_keys: []const []const u8,

    /// The version of the operating system of the image for the Exascale VM
    /// cluster.
    system_version: ?[]const u8 = null,

    /// The list of resource tags to apply to the Exascale VM cluster.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The time zone for the Exascale VM cluster.
    time_zone: ?[]const u8 = null,

    /// The total number of ECPUs for the Exascale VM cluster.
    total_ecpu_count: i32,

    /// The total amount of file system storage, in gigabytes (GB), for the Exascale
    /// VM cluster.
    vm_file_system_storage_total_size_in_g_bs: i32,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .cluster_name = "clusterName",
        .data_collection_options = "dataCollectionOptions",
        .display_name = "displayName",
        .enabled_ecpu_count = "enabledEcpuCount",
        .exascale_db_storage_vault_id = "exascaleDbStorageVaultId",
        .grid_image_id = "gridImageId",
        .hostname = "hostname",
        .license_model = "licenseModel",
        .node_count = "nodeCount",
        .odb_network_id = "odbNetworkId",
        .scan_listener_port_tcp = "scanListenerPortTcp",
        .scan_listener_port_tcp_ssl = "scanListenerPortTcpSsl",
        .shape = "shape",
        .shape_attribute = "shapeAttribute",
        .ssh_public_keys = "sshPublicKeys",
        .system_version = "systemVersion",
        .tags = "tags",
        .time_zone = "timeZone",
        .total_ecpu_count = "totalEcpuCount",
        .vm_file_system_storage_total_size_in_g_bs = "vmFileSystemStorageTotalSizeInGBs",
    };
};

pub const CreateExadbVmClusterOutput = struct {
    /// The user-friendly name for the Exascale VM cluster.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the Exascale VM cluster.
    exadb_vm_cluster_id: []const u8,

    /// The current status of the Exascale VM cluster.
    status: ?ResourceStatus = null,

    /// Additional information about the status of the Exascale VM cluster.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
        .exadb_vm_cluster_id = "exadbVmClusterId",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateExadbVmClusterInput, options: CallOptions) !CreateExadbVmClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateExadbVmClusterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Odb.CreateExadbVmCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateExadbVmClusterOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateExadbVmClusterOutput, body, allocator);
}
