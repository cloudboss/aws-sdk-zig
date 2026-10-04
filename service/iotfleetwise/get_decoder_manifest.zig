const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ManifestStatus = @import("manifest_status.zig").ManifestStatus;

pub const GetDecoderManifestInput = struct {
    /// The name of the decoder manifest to retrieve information about.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};

pub const GetDecoderManifestOutput = struct {
    /// The Amazon Resource Name (ARN) of the decoder manifest.
    arn: []const u8,

    /// The time the decoder manifest was created in seconds since epoch (January 1,
    /// 1970 at midnight UTC time).
    creation_time: i64,

    /// A brief description of the decoder manifest.
    description: ?[]const u8 = null,

    /// The time the decoder manifest was last updated in seconds since epoch
    /// (January 1, 1970 at midnight UTC time).
    last_modification_time: i64,

    /// The detailed message for the decoder manifest. When a decoder manifest is in
    /// an
    /// `INVALID` status, the message contains detailed reason and help
    /// information.
    message: ?[]const u8 = null,

    /// The ARN of a vehicle model (model manifest) associated with the decoder
    /// manifest.
    model_manifest_arn: ?[]const u8 = null,

    /// The name of the decoder manifest.
    name: []const u8,

    /// The state of the decoder manifest. If the status is `ACTIVE`, the decoder
    /// manifest can't be edited. If the status is marked `DRAFT`, you can edit the
    /// decoder manifest.
    status: ?ManifestStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .last_modification_time = "lastModificationTime",
        .message = "message",
        .model_manifest_arn = "modelManifestArn",
        .name = "name",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDecoderManifestInput, options: CallOptions) !GetDecoderManifestOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotfleetwise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDecoderManifestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotfleetwise", "IoTFleetWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.GetDecoderManifest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDecoderManifestOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetDecoderManifestOutput, body, allocator);
}
