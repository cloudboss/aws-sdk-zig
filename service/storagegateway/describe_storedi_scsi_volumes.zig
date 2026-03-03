const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const StorediSCSIVolume = @import("storedi_scsi_volume.zig").StorediSCSIVolume;

pub const DescribeStorediSCSIVolumesInput = struct {
    /// An array of strings where each string represents the Amazon Resource Name
    /// (ARN) of a
    /// stored volume. All of the specified stored volumes must be from the same
    /// gateway. Use ListVolumes to get volume ARNs for a gateway.
    volume_ar_ns: []const []const u8,

    pub const json_field_names = .{
        .volume_ar_ns = "VolumeARNs",
    };
};

pub const DescribeStorediSCSIVolumesOutput = struct {
    /// Describes a single unit of output from DescribeStorediSCSIVolumes. The
    /// following fields are returned:
    ///
    /// * `ChapEnabled`: Indicates whether mutual CHAP is enabled for the iSCSI
    /// target.
    ///
    /// * `LunNumber`: The logical disk number.
    ///
    /// * `NetworkInterfaceId`: The network interface ID of the stored volume that
    /// initiator use to map the stored volume as an iSCSI target.
    ///
    /// * `NetworkInterfacePort`: The port used to communicate with iSCSI
    /// targets.
    ///
    /// * `PreservedExistingData`: Indicates when the stored volume was created,
    /// existing data on the underlying local disk was preserved.
    ///
    /// * `SourceSnapshotId`: If the stored volume was created from a snapshot, this
    /// field contains the snapshot ID used, e.g. `snap-1122aabb`. Otherwise, this
    /// field is not included.
    ///
    /// * `StorediSCSIVolumes`: An array of StorediSCSIVolume objects where each
    /// object contains metadata about one stored volume.
    ///
    /// * `TargetARN`: The Amazon Resource Name (ARN) of the volume target.
    ///
    /// * `VolumeARN`: The Amazon Resource Name (ARN) of the stored volume.
    ///
    /// * `VolumeDiskId`: The disk ID of the local disk that was specified in the
    /// CreateStorediSCSIVolume operation.
    ///
    /// * `VolumeId`: The unique identifier of the storage volume, e.g.
    /// `vol-1122AABB`.
    ///
    /// * `VolumeiSCSIAttributes`: An VolumeiSCSIAttributes object
    /// that represents a collection of iSCSI attributes for one stored volume.
    ///
    /// * `VolumeProgress`: Represents the percentage complete if the volume is
    /// restoring or bootstrapping that represents the percent of data transferred.
    /// This
    /// field does not appear in the response if the stored volume is not restoring
    /// or
    /// bootstrapping.
    ///
    /// * `VolumeSizeInBytes`: The size of the volume in bytes.
    ///
    /// * `VolumeStatus`: One of the `VolumeStatus` values that indicates
    /// the state of the volume.
    ///
    /// * `VolumeType`: One of the enumeration values describing the type of the
    /// volume. Currently, only `STORED` volumes are supported.
    storedi_scsi_volumes: ?[]const StorediSCSIVolume = null,

    pub const json_field_names = .{
        .storedi_scsi_volumes = "StorediSCSIVolumes",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStorediSCSIVolumesInput, options: Options) !DescribeStorediSCSIVolumesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "storagegateway");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStorediSCSIVolumesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StorageGateway_20130630.DescribeStorediSCSIVolumes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStorediSCSIVolumesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeStorediSCSIVolumesOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
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

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGatewayRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_gateway_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableError")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_error = .{
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
