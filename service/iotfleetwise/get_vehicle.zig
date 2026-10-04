const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StateTemplateAssociation = @import("state_template_association.zig").StateTemplateAssociation;

pub const GetVehicleInput = struct {
    /// The ID of the vehicle to retrieve information about.
    vehicle_name: []const u8,

    pub const json_field_names = .{
        .vehicle_name = "vehicleName",
    };
};

pub const GetVehicleOutput = struct {
    /// The Amazon Resource Name (ARN) of the vehicle to retrieve information about.
    arn: ?[]const u8 = null,

    /// Static information about a vehicle in a key-value pair. For example:
    ///
    /// `"engineType"` : `"1.3 L R2"`
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The time the vehicle was created in seconds since epoch (January 1, 1970 at
    /// midnight UTC time).
    creation_time: ?i64 = null,

    /// The ARN of a decoder manifest associated with the vehicle.
    decoder_manifest_arn: ?[]const u8 = null,

    /// The time the vehicle was last updated in seconds since epoch (January 1,
    /// 1970 at midnight UTC time).
    last_modification_time: ?i64 = null,

    /// The ARN of a vehicle model (model manifest) associated with the vehicle.
    model_manifest_arn: ?[]const u8 = null,

    /// State templates associated with the vehicle.
    state_templates: ?[]const StateTemplateAssociation = null,

    /// The ID of the vehicle.
    vehicle_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .attributes = "attributes",
        .creation_time = "creationTime",
        .decoder_manifest_arn = "decoderManifestArn",
        .last_modification_time = "lastModificationTime",
        .model_manifest_arn = "modelManifestArn",
        .state_templates = "stateTemplates",
        .vehicle_name = "vehicleName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetVehicleInput, options: CallOptions) !GetVehicleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetVehicleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.GetVehicle");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetVehicleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetVehicleOutput, body, allocator);
}
