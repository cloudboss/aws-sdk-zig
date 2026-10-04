const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeleteVolumeOntapConfiguration = @import("delete_volume_ontap_configuration.zig").DeleteVolumeOntapConfiguration;
const DeleteVolumeOpenZFSConfiguration = @import("delete_volume_open_zfs_configuration.zig").DeleteVolumeOpenZFSConfiguration;
const VolumeLifecycle = @import("volume_lifecycle.zig").VolumeLifecycle;
const DeleteVolumeOntapResponse = @import("delete_volume_ontap_response.zig").DeleteVolumeOntapResponse;

pub const DeleteVolumeInput = struct {
    client_request_token: ?[]const u8 = null,

    /// For Amazon FSx for ONTAP volumes, specify whether to take a final backup of
    /// the volume and apply tags to the backup. To apply tags to the backup, you
    /// must have the
    /// `fsx:TagResource` permission.
    ontap_configuration: ?DeleteVolumeOntapConfiguration = null,

    /// For Amazon FSx for OpenZFS volumes, specify whether to delete all child
    /// volumes and snapshots.
    open_zfs_configuration: ?DeleteVolumeOpenZFSConfiguration = null,

    /// The ID of the volume that you are deleting.
    volume_id: []const u8,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .ontap_configuration = "OntapConfiguration",
        .open_zfs_configuration = "OpenZFSConfiguration",
        .volume_id = "VolumeId",
    };
};

pub const DeleteVolumeOutput = struct {
    /// The lifecycle state of the volume being deleted. If the `DeleteVolume`
    /// operation is successful, this value is `DELETING`.
    lifecycle: ?VolumeLifecycle = null,

    /// Returned after a `DeleteVolume` request, showing the status of the delete
    /// request.
    ontap_response: ?DeleteVolumeOntapResponse = null,

    /// The ID of the volume that's being deleted.
    volume_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .lifecycle = "Lifecycle",
        .ontap_response = "OntapResponse",
        .volume_id = "VolumeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteVolumeInput, options: CallOptions) !DeleteVolumeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fsx", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteVolumeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fsx", "FSx", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.DeleteVolume");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteVolumeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteVolumeOutput, body, allocator);
}
