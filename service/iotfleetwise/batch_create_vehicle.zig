const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateVehicleRequestItem = @import("create_vehicle_request_item.zig").CreateVehicleRequestItem;
const CreateVehicleError = @import("create_vehicle_error.zig").CreateVehicleError;
const CreateVehicleResponseItem = @import("create_vehicle_response_item.zig").CreateVehicleResponseItem;

pub const BatchCreateVehicleInput = struct {
    /// A list of information about each vehicle to create. For more information,
    /// see the
    /// API data type.
    vehicles: []const CreateVehicleRequestItem,

    pub const json_field_names = .{
        .vehicles = "vehicles",
    };
};

pub const BatchCreateVehicleOutput = struct {
    /// A list of information about creation errors, or an empty list if there
    /// aren't any
    /// errors.
    errors: ?[]const CreateVehicleError = null,

    /// A list of information about a batch of created vehicles. For more
    /// information, see
    /// the API data type.
    vehicles: ?[]const CreateVehicleResponseItem = null,

    pub const json_field_names = .{
        .errors = "errors",
        .vehicles = "vehicles",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchCreateVehicleInput, options: CallOptions) !BatchCreateVehicleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchCreateVehicleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.BatchCreateVehicle");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchCreateVehicleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchCreateVehicleOutput, body, allocator);
}
