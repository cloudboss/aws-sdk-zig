const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const VolumeTypeEnum = @import("volume_type_enum.zig").VolumeTypeEnum;

pub const CreateVolumeInput = struct {
    /// Availability zone for the volume.
    availability_zone: []const u8,

    /// Unique token to prevent duplicate volume creation.
    client_token: ?[]const u8 = null,

    /// Indicates if the volume should be encrypted.
    encrypted: ?bool = null,

    /// Input/output operations per second for the volume.
    iops: ?i32 = null,

    /// KMS key for volume encryption.
    kms_key_id: ?[]const u8 = null,

    /// Volume size in gigabytes.
    size_in_gb: ?i32 = null,

    /// Source snapshot for volume creation.
    snapshot_id: ?[]const u8 = null,

    /// Metadata tags for the volume.
    tag_specifications: ?[]const TagSpecification = null,

    /// Volume throughput performance.
    throughput: ?i32 = null,

    /// Type of EBS volume.
    volume_type: ?VolumeTypeEnum = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .client_token = "ClientToken",
        .encrypted = "Encrypted",
        .iops = "Iops",
        .kms_key_id = "KmsKeyId",
        .size_in_gb = "SizeInGB",
        .snapshot_id = "SnapshotId",
        .tag_specifications = "TagSpecifications",
        .throughput = "Throughput",
        .volume_type = "VolumeType",
    };
};

pub const CreateVolumeOutput = struct {
    /// Unique identifier for the new volume.
    volume_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .volume_id = "VolumeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVolumeInput, options: CallOptions) !CreateVolumeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces-instances", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVolumeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces-instances", "Workspaces Instances", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "EUCMIFrontendAPIService.CreateVolume");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVolumeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateVolumeOutput, body, allocator);
}
