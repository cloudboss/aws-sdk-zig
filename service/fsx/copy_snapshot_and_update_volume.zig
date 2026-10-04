const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OpenZFSCopyStrategy = @import("open_zfs_copy_strategy.zig").OpenZFSCopyStrategy;
const UpdateOpenZFSVolumeOption = @import("update_open_zfs_volume_option.zig").UpdateOpenZFSVolumeOption;
const AdministrativeAction = @import("administrative_action.zig").AdministrativeAction;
const VolumeLifecycle = @import("volume_lifecycle.zig").VolumeLifecycle;

pub const CopySnapshotAndUpdateVolumeInput = struct {
    client_request_token: ?[]const u8 = null,

    /// Specifies the strategy to use when copying data from a snapshot to the
    /// volume.
    ///
    /// * `FULL_COPY` - Copies all data from the snapshot to the volume.
    ///
    /// * `INCREMENTAL_COPY` - Copies only the snapshot data that's changed
    /// since the previous replication.
    ///
    /// `CLONE` isn't a valid copy strategy option for the
    /// `CopySnapshotAndUpdateVolume` operation.
    copy_strategy: ?OpenZFSCopyStrategy = null,

    /// Confirms that you want to delete data on the destination volume that wasn’t
    /// there
    /// during the previous snapshot replication.
    ///
    /// Your replication will fail if you don’t include an option for a specific
    /// type of data
    /// and that data is on your destination. For example, if you don’t include
    /// `DELETE_INTERMEDIATE_SNAPSHOTS` and there are intermediate snapshots on
    /// the destination, you can’t copy the snapshot.
    ///
    /// * `DELETE_INTERMEDIATE_SNAPSHOTS` - Deletes snapshots on the
    /// destination volume that aren’t on the source volume.
    ///
    /// * `DELETE_CLONED_VOLUMES` - Deletes snapshot clones on the
    /// destination volume that aren't on the source volume.
    ///
    /// * `DELETE_INTERMEDIATE_DATA` - Overwrites snapshots on the
    /// destination volume that don’t match the source snapshot that you’re
    /// copying.
    options: ?[]const UpdateOpenZFSVolumeOption = null,

    source_snapshot_arn: []const u8,

    /// Specifies the ID of the volume that you are copying the snapshot to.
    volume_id: []const u8,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .copy_strategy = "CopyStrategy",
        .options = "Options",
        .source_snapshot_arn = "SourceSnapshotARN",
        .volume_id = "VolumeId",
    };
};

pub const CopySnapshotAndUpdateVolumeOutput = struct {
    /// A list of administrative actions for the file system that are in process or
    /// waiting to
    /// be processed. Administrative actions describe changes to the Amazon FSx
    /// system.
    administrative_actions: ?[]const AdministrativeAction = null,

    /// The lifecycle state of the destination volume.
    lifecycle: ?VolumeLifecycle = null,

    /// The ID of the volume that you copied the snapshot to.
    volume_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .administrative_actions = "AdministrativeActions",
        .lifecycle = "Lifecycle",
        .volume_id = "VolumeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopySnapshotAndUpdateVolumeInput, options: CallOptions) !CopySnapshotAndUpdateVolumeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CopySnapshotAndUpdateVolumeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CopySnapshotAndUpdateVolume");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopySnapshotAndUpdateVolumeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CopySnapshotAndUpdateVolumeOutput, body, allocator);
}
