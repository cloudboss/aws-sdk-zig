const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateVehicleRequestItem = @import("update_vehicle_request_item.zig").UpdateVehicleRequestItem;
const UpdateVehicleError = @import("update_vehicle_error.zig").UpdateVehicleError;
const UpdateVehicleResponseItem = @import("update_vehicle_response_item.zig").UpdateVehicleResponseItem;

pub const BatchUpdateVehicleInput = struct {
    /// A list of information about the vehicles to update. For more information,
    /// see the
    /// API data type.
    vehicles: []const UpdateVehicleRequestItem,

    pub const json_field_names = .{
        .vehicles = "vehicles",
    };
};

pub const BatchUpdateVehicleOutput = struct {
    /// A list of information about errors returned while updating a batch of
    /// vehicles, or, if
    /// there aren't any errors, an empty list.
    errors: ?[]const UpdateVehicleError = null,

    /// A list of information about the batch of updated vehicles.
    ///
    /// This list contains only unique IDs for the vehicles that were updated.
    vehicles: ?[]const UpdateVehicleResponseItem = null,

    pub const json_field_names = .{
        .errors = "errors",
        .vehicles = "vehicles",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateVehicleInput, options: CallOptions) !BatchUpdateVehicleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateVehicleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.BatchUpdateVehicle");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateVehicleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchUpdateVehicleOutput, body, allocator);
}
