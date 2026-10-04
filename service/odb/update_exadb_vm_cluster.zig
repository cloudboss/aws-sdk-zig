const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataCollectionOptions = @import("data_collection_options.zig").DataCollectionOptions;
const LicenseModel = @import("license_model.zig").LicenseModel;
const UpdateAction = @import("update_action.zig").UpdateAction;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const UpdateExadbVmClusterInput = struct {
    /// The set of preferences for the various diagnostic collection options for the
    /// Exascale VM cluster.
    data_collection_options: ?DataCollectionOptions = null,

    /// A new user-friendly name for the Exascale VM cluster.
    display_name: ?[]const u8 = null,

    /// The number of ECPUs to enable for the Exascale VM cluster.
    enabled_ecpu_count: ?i32 = null,

    /// The unique identifier of the Exascale VM cluster to update.
    exadb_vm_cluster_id: []const u8,

    /// The Grid Infrastructure software image ID for the Exascale VM cluster.
    grid_image_id: ?[]const u8 = null,

    /// The Oracle license model to apply to the Exascale VM cluster.
    license_model: ?LicenseModel = null,

    /// The public key portion of one or more key pairs used for SSH access to the
    /// Exascale VM cluster.
    ssh_public_keys: ?[]const []const u8 = null,

    /// The version of the operating system of the image for the Exascale VM
    /// cluster.
    system_version: ?[]const u8 = null,

    /// The total number of ECPUs for the Exascale VM cluster.
    total_ecpu_count: ?i32 = null,

    /// The update action to perform on the Exascale VM cluster.
    update_action: ?UpdateAction = null,

    /// The total amount of file system storage, in gigabytes (GB), for the Exascale
    /// VM cluster.
    vm_file_system_storage_total_size_in_g_bs: ?i32 = null,

    pub const json_field_names = .{
        .data_collection_options = "dataCollectionOptions",
        .display_name = "displayName",
        .enabled_ecpu_count = "enabledEcpuCount",
        .exadb_vm_cluster_id = "exadbVmClusterId",
        .grid_image_id = "gridImageId",
        .license_model = "licenseModel",
        .ssh_public_keys = "sshPublicKeys",
        .system_version = "systemVersion",
        .total_ecpu_count = "totalEcpuCount",
        .update_action = "updateAction",
        .vm_file_system_storage_total_size_in_g_bs = "vmFileSystemStorageTotalSizeInGBs",
    };
};

pub const UpdateExadbVmClusterOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateExadbVmClusterInput, options: CallOptions) !UpdateExadbVmClusterOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateExadbVmClusterInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Odb.UpdateExadbVmCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateExadbVmClusterOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateExadbVmClusterOutput, body, allocator);
}
