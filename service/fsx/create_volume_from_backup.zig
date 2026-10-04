const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateOntapVolumeConfiguration = @import("create_ontap_volume_configuration.zig").CreateOntapVolumeConfiguration;
const Tag = @import("tag.zig").Tag;
const Volume = @import("volume.zig").Volume;

pub const CreateVolumeFromBackupInput = struct {
    backup_id: []const u8,

    client_request_token: ?[]const u8 = null,

    /// The name of the new volume you're creating.
    name: []const u8,

    /// Specifies the configuration of the ONTAP volume that you are creating.
    ontap_configuration: ?CreateOntapVolumeConfiguration = null,

    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .backup_id = "BackupId",
        .client_request_token = "ClientRequestToken",
        .name = "Name",
        .ontap_configuration = "OntapConfiguration",
        .tags = "Tags",
    };
};

pub const CreateVolumeFromBackupOutput = struct {
    /// Returned after a successful `CreateVolumeFromBackup` API operation,
    /// describing the volume just created.
    volume: ?Volume = null,

    pub const json_field_names = .{
        .volume = "Volume",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVolumeFromBackupInput, options: CallOptions) !CreateVolumeFromBackupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVolumeFromBackupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CreateVolumeFromBackup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVolumeFromBackupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateVolumeFromBackupOutput, body, allocator);
}
