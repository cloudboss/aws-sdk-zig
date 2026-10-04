const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VehicleAssociationBehavior = @import("vehicle_association_behavior.zig").VehicleAssociationBehavior;
const StateTemplateAssociation = @import("state_template_association.zig").StateTemplateAssociation;
const Tag = @import("tag.zig").Tag;

pub const CreateVehicleInput = struct {
    /// An option to create a new Amazon Web Services IoT thing when creating a
    /// vehicle, or to validate an
    /// existing Amazon Web Services IoT thing as a vehicle.
    ///
    /// Default:
    association_behavior: ?VehicleAssociationBehavior = null,

    /// Static information about a vehicle in a key-value pair. For example:
    /// `"engineType"` : `"1.3 L R2"`
    ///
    /// To use attributes with Campaigns or State Templates, you must include them
    /// using the
    /// request parameters `dataExtraDimensions` and/or `metadataExtraDimensions`
    /// (for state templates only) when creating your campaign/state template.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of a decoder manifest.
    decoder_manifest_arn: []const u8,

    /// The Amazon Resource Name ARN of a vehicle model.
    model_manifest_arn: []const u8,

    /// Associate state templates with the vehicle. You can monitor the last known
    /// state of the vehicle in near real time.
    state_templates: ?[]const StateTemplateAssociation = null,

    /// Metadata that can be used to manage the vehicle.
    tags: ?[]const Tag = null,

    /// The unique ID of the vehicle to create.
    vehicle_name: []const u8,

    pub const json_field_names = .{
        .association_behavior = "associationBehavior",
        .attributes = "attributes",
        .decoder_manifest_arn = "decoderManifestArn",
        .model_manifest_arn = "modelManifestArn",
        .state_templates = "stateTemplates",
        .tags = "tags",
        .vehicle_name = "vehicleName",
    };
};

pub const CreateVehicleOutput = struct {
    /// The ARN of the created vehicle.
    arn: ?[]const u8 = null,

    /// The ARN of a created or validated Amazon Web Services IoT thing.
    thing_arn: ?[]const u8 = null,

    /// The unique ID of the created vehicle.
    vehicle_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .thing_arn = "thingArn",
        .vehicle_name = "vehicleName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVehicleInput, options: CallOptions) !CreateVehicleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVehicleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.CreateVehicle");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVehicleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateVehicleOutput, body, allocator);
}
