const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateOntapVolumeConfiguration = @import("update_ontap_volume_configuration.zig").UpdateOntapVolumeConfiguration;
const UpdateOpenZFSVolumeConfiguration = @import("update_open_zfs_volume_configuration.zig").UpdateOpenZFSVolumeConfiguration;
const Volume = @import("volume.zig").Volume;

pub const UpdateVolumeInput = struct {
    client_request_token: ?[]const u8 = null,

    /// The name of the OpenZFS volume. OpenZFS root volumes are automatically named
    /// `FSX`. Child volume names must be unique among their parent volume's
    /// children. The name of the volume is part of the mount string for the OpenZFS
    /// volume.
    name: ?[]const u8 = null,

    /// The configuration of the ONTAP volume that you are updating.
    ontap_configuration: ?UpdateOntapVolumeConfiguration = null,

    /// The configuration of the OpenZFS volume that you are updating.
    open_zfs_configuration: ?UpdateOpenZFSVolumeConfiguration = null,

    /// The ID of the volume that you want to update, in the format
    /// `fsvol-0123456789abcdef0`.
    volume_id: []const u8,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .name = "Name",
        .ontap_configuration = "OntapConfiguration",
        .open_zfs_configuration = "OpenZFSConfiguration",
        .volume_id = "VolumeId",
    };
};

pub const UpdateVolumeOutput = struct {
    /// A description of the volume just updated. Returned after a successful
    /// `UpdateVolume` API operation.
    volume: ?Volume = null,

    pub const json_field_names = .{
        .volume = "Volume",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateVolumeInput, options: CallOptions) !UpdateVolumeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateVolumeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.UpdateVolume");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateVolumeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateVolumeOutput, body, allocator);
}
