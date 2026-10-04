const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateMode = @import("update_mode.zig").UpdateMode;
const StateTemplateAssociation = @import("state_template_association.zig").StateTemplateAssociation;

pub const UpdateVehicleInput = struct {
    /// Static information about a vehicle in a key-value pair. For example:
    ///
    /// `"engineType"` : `"1.3 L R2"`
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The method the specified attributes will update the existing attributes on
    /// the
    /// vehicle. Use`Overwite` to replace the vehicle attributes with the specified
    /// attributes. Or use `Merge` to combine all attributes.
    ///
    /// This is required if attributes are present in the input.
    attribute_update_mode: ?UpdateMode = null,

    /// The ARN of the decoder manifest associated with this vehicle.
    decoder_manifest_arn: ?[]const u8 = null,

    /// The ARN of a vehicle model (model manifest) associated with the vehicle.
    model_manifest_arn: ?[]const u8 = null,

    /// Associate state templates with the vehicle.
    state_templates_to_add: ?[]const StateTemplateAssociation = null,

    /// Remove state templates from the vehicle.
    state_templates_to_remove: ?[]const []const u8 = null,

    /// Change the `stateTemplateUpdateStrategy` of state templates already
    /// associated with the vehicle.
    state_templates_to_update: ?[]const StateTemplateAssociation = null,

    /// The unique ID of the vehicle to update.
    vehicle_name: []const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .attribute_update_mode = "attributeUpdateMode",
        .decoder_manifest_arn = "decoderManifestArn",
        .model_manifest_arn = "modelManifestArn",
        .state_templates_to_add = "stateTemplatesToAdd",
        .state_templates_to_remove = "stateTemplatesToRemove",
        .state_templates_to_update = "stateTemplatesToUpdate",
        .vehicle_name = "vehicleName",
    };
};

pub const UpdateVehicleOutput = struct {
    /// The ARN of the updated vehicle.
    arn: ?[]const u8 = null,

    /// The ID of the updated vehicle.
    vehicle_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .vehicle_name = "vehicleName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateVehicleInput, options: CallOptions) !UpdateVehicleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateVehicleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.UpdateVehicle");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateVehicleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateVehicleOutput, body, allocator);
}
