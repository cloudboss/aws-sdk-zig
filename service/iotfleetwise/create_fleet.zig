const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateFleetInput = struct {
    /// A brief description of the fleet to create.
    description: ?[]const u8 = null,

    /// The unique ID of the fleet to create.
    fleet_id: []const u8,

    /// The Amazon Resource Name (ARN) of a signal catalog.
    signal_catalog_arn: []const u8,

    /// Metadata that can be used to manage the fleet.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "description",
        .fleet_id = "fleetId",
        .signal_catalog_arn = "signalCatalogArn",
        .tags = "tags",
    };
};

pub const CreateFleetOutput = struct {
    /// The ARN of the created fleet.
    arn: []const u8,

    /// The ID of the created fleet.
    id: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFleetInput, options: CallOptions) !CreateFleetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFleetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.CreateFleet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFleetOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateFleetOutput, body, allocator);
}
