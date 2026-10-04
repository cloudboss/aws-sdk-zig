const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetStateTemplateInput = struct {
    /// The unique ID of the state template.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
    };
};

pub const GetStateTemplateOutput = struct {
    /// The Amazon Resource Name (ARN) of the state template.
    arn: ?[]const u8 = null,

    /// The time the state template was created in seconds since epoch (January 1,
    /// 1970 at midnight UTC time).
    creation_time: ?i64 = null,

    /// A list of vehicle attributes associated with the payload published on the
    /// state template's
    /// MQTT topic.
    ///
    /// Default: An empty array
    data_extra_dimensions: ?[]const []const u8 = null,

    /// A brief description of the state template.
    description: ?[]const u8 = null,

    /// The unique ID of the state template.
    id: ?[]const u8 = null,

    /// The time the state template was last updated in seconds since epoch (January
    /// 1, 1970 at midnight UTC time).
    last_modification_time: ?i64 = null,

    /// A list of vehicle attributes to associate with user properties of the
    /// messages published on the
    /// state template's MQTT topic.
    ///
    /// Default: An empty array
    metadata_extra_dimensions: ?[]const []const u8 = null,

    /// The name of the state template.
    name: ?[]const u8 = null,

    /// The ARN of the signal catalog associated with the state template.
    signal_catalog_arn: ?[]const u8 = null,

    /// A list of signals from which data is collected. The state template
    /// properties contain the fully qualified names of the signals.
    state_template_properties: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .data_extra_dimensions = "dataExtraDimensions",
        .description = "description",
        .id = "id",
        .last_modification_time = "lastModificationTime",
        .metadata_extra_dimensions = "metadataExtraDimensions",
        .name = "name",
        .signal_catalog_arn = "signalCatalogArn",
        .state_template_properties = "stateTemplateProperties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStateTemplateInput, options: CallOptions) !GetStateTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetStateTemplateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.GetStateTemplate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStateTemplateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetStateTemplateOutput, body, allocator);
}
