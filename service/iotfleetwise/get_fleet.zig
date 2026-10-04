const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetFleetInput = struct {
    /// The ID of the fleet to retrieve information about.
    fleet_id: []const u8,

    pub const json_field_names = .{
        .fleet_id = "fleetId",
    };
};

pub const GetFleetOutput = struct {
    /// The Amazon Resource Name (ARN) of the fleet.
    arn: []const u8,

    /// The time the fleet was created in seconds since epoch (January 1, 1970 at
    /// midnight
    /// UTC time).
    creation_time: i64,

    /// A brief description of the fleet.
    description: ?[]const u8 = null,

    /// The ID of the fleet.
    id: []const u8,

    /// The time the fleet was last updated, in seconds since epoch (January 1, 1970
    /// at
    /// midnight UTC time).
    last_modification_time: i64,

    /// The ARN of a signal catalog associated with the fleet.
    signal_catalog_arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .last_modification_time = "lastModificationTime",
        .signal_catalog_arn = "signalCatalogArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFleetInput, options: CallOptions) !GetFleetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFleetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.GetFleet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFleetOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetFleetOutput, body, allocator);
}
