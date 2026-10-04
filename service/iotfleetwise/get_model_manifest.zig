const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ManifestStatus = @import("manifest_status.zig").ManifestStatus;

pub const GetModelManifestInput = struct {
    /// The name of the vehicle model to retrieve information about.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};

pub const GetModelManifestOutput = struct {
    /// The Amazon Resource Name (ARN) of the vehicle model.
    arn: []const u8,

    /// The time the vehicle model was created, in seconds since epoch (January 1,
    /// 1970 at
    /// midnight UTC time).
    creation_time: i64,

    /// A brief description of the vehicle model.
    description: ?[]const u8 = null,

    /// The last time the vehicle model was modified.
    last_modification_time: i64,

    /// The name of the vehicle model.
    name: []const u8,

    /// The ARN of the signal catalog associated with the vehicle model.
    signal_catalog_arn: ?[]const u8 = null,

    /// The state of the vehicle model. If the status is `ACTIVE`, the vehicle
    /// model can't be edited. You can edit the vehicle model if the status is
    /// marked
    /// `DRAFT`.
    status: ?ManifestStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .last_modification_time = "lastModificationTime",
        .name = "name",
        .signal_catalog_arn = "signalCatalogArn",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetModelManifestInput, options: CallOptions) !GetModelManifestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetModelManifestInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.GetModelManifest");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetModelManifestOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetModelManifestOutput, body, allocator);
}
