const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RestoreOpenZFSVolumeOption = @import("restore_open_zfs_volume_option.zig").RestoreOpenZFSVolumeOption;
const AdministrativeAction = @import("administrative_action.zig").AdministrativeAction;
const VolumeLifecycle = @import("volume_lifecycle.zig").VolumeLifecycle;

pub const RestoreVolumeFromSnapshotInput = struct {
    client_request_token: ?[]const u8 = null,

    /// The settings used when restoring the specified volume from snapshot.
    ///
    /// * `DELETE_INTERMEDIATE_SNAPSHOTS` - Deletes snapshots between the
    /// current state and the specified snapshot. If there are intermediate
    /// snapshots
    /// and this option isn't used, `RestoreVolumeFromSnapshot` fails.
    ///
    /// * `DELETE_CLONED_VOLUMES` - Deletes any dependent clone volumes
    /// created from intermediate snapshots. If there are any dependent clone
    /// volumes and this
    /// option isn't used, `RestoreVolumeFromSnapshot` fails.
    options: ?[]const RestoreOpenZFSVolumeOption = null,

    /// The ID of the source snapshot. Specifies the snapshot that you are restoring
    /// from.
    snapshot_id: []const u8,

    /// The ID of the volume that you are restoring.
    volume_id: []const u8,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .options = "Options",
        .snapshot_id = "SnapshotId",
        .volume_id = "VolumeId",
    };
};

pub const RestoreVolumeFromSnapshotOutput = struct {
    /// A list of administrative actions for the file system that are in process or
    /// waiting to
    /// be processed. Administrative actions describe changes to the Amazon FSx
    /// system.
    administrative_actions: ?[]const AdministrativeAction = null,

    /// The lifecycle state of the volume being restored.
    lifecycle: ?VolumeLifecycle = null,

    /// The ID of the volume that you restored.
    volume_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .administrative_actions = "AdministrativeActions",
        .lifecycle = "Lifecycle",
        .volume_id = "VolumeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreVolumeFromSnapshotInput, options: CallOptions) !RestoreVolumeFromSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreVolumeFromSnapshotInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.RestoreVolumeFromSnapshot");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreVolumeFromSnapshotOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RestoreVolumeFromSnapshotOutput, body, allocator);
}
