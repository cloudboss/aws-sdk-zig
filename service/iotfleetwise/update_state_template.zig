const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateStateTemplateInput = struct {
    /// A list of vehicle attributes to associate with the payload published on the
    /// state template's
    /// MQTT topic. (See [
    /// Processing last known state vehicle data using MQTT
    /// messaging](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/process-visualize-data.html#process-last-known-state-vehicle-data)). For example, if you add
    /// `Vehicle.Attributes.Make` and `Vehicle.Attributes.Model` attributes, Amazon
    /// Web Services IoT FleetWise
    /// will enrich the protobuf encoded payload with those attributes in the
    /// `extraDimensions`
    /// field.
    ///
    /// Default: An empty array
    data_extra_dimensions: ?[]const []const u8 = null,

    /// A brief description of the state template.
    description: ?[]const u8 = null,

    /// The unique ID of the state template.
    identifier: []const u8,

    /// A list of vehicle attributes to associate with user properties of the
    /// messages published on the
    /// state template's MQTT topic. (See [
    /// Processing last known state vehicle data using MQTT
    /// messaging](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/process-visualize-data.html#process-last-known-state-vehicle-data)). For example, if you add
    /// `Vehicle.Attributes.Make` and `Vehicle.Attributes.Model` attributes, Amazon
    /// Web Services IoT FleetWise
    /// will include these attributes as User Properties with the MQTT message.
    metadata_extra_dimensions: ?[]const []const u8 = null,

    /// Add signals from which data is collected as part of the state template.
    state_template_properties_to_add: ?[]const []const u8 = null,

    /// Remove signals from which data is collected as part of the state template.
    state_template_properties_to_remove: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .data_extra_dimensions = "dataExtraDimensions",
        .description = "description",
        .identifier = "identifier",
        .metadata_extra_dimensions = "metadataExtraDimensions",
        .state_template_properties_to_add = "stateTemplatePropertiesToAdd",
        .state_template_properties_to_remove = "stateTemplatePropertiesToRemove",
    };
};

pub const UpdateStateTemplateOutput = struct {
    /// The Amazon Resource Name (ARN) of the state template.
    arn: ?[]const u8 = null,

    /// The unique ID of the state template.
    id: ?[]const u8 = null,

    /// The name of the state template.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .name = "name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateStateTemplateInput, options: CallOptions) !UpdateStateTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateStateTemplateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.UpdateStateTemplate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateStateTemplateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateStateTemplateOutput, body, allocator);
}
