const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateOntapVolumeConfiguration = @import("create_ontap_volume_configuration.zig").CreateOntapVolumeConfiguration;
const CreateOpenZFSVolumeConfiguration = @import("create_open_zfs_volume_configuration.zig").CreateOpenZFSVolumeConfiguration;
const Tag = @import("tag.zig").Tag;
const VolumeType = @import("volume_type.zig").VolumeType;
const Volume = @import("volume.zig").Volume;

pub const CreateVolumeInput = struct {
    client_request_token: ?[]const u8 = null,

    /// Specifies the name of the volume that you're creating.
    name: []const u8,

    /// Specifies the configuration to use when creating the ONTAP volume.
    ontap_configuration: ?CreateOntapVolumeConfiguration = null,

    /// Specifies the configuration to use when creating the OpenZFS volume.
    open_zfs_configuration: ?CreateOpenZFSVolumeConfiguration = null,

    tags: ?[]const Tag = null,

    /// Specifies the type of volume to create; `ONTAP` and `OPENZFS` are
    /// the only valid volume types.
    volume_type: VolumeType,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .name = "Name",
        .ontap_configuration = "OntapConfiguration",
        .open_zfs_configuration = "OpenZFSConfiguration",
        .tags = "Tags",
        .volume_type = "VolumeType",
    };
};

pub const CreateVolumeOutput = struct {
    /// Returned after a successful `CreateVolume` API operation, describing the
    /// volume just created.
    volume: ?Volume = null,

    pub const json_field_names = .{
        .volume = "Volume",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVolumeInput, options: CallOptions) !CreateVolumeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVolumeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CreateVolume");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVolumeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateVolumeOutput, body, allocator);
}
