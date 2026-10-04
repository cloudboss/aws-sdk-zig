const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataIntegrationFlowSource = @import("data_integration_flow_source.zig").DataIntegrationFlowSource;
const DataIntegrationFlowTarget = @import("data_integration_flow_target.zig").DataIntegrationFlowTarget;
const DataIntegrationFlowTransformation = @import("data_integration_flow_transformation.zig").DataIntegrationFlowTransformation;

pub const CreateDataIntegrationFlowInput = struct {
    /// The Amazon Web Services Supply Chain instance identifier.
    instance_id: []const u8,

    /// Name of the DataIntegrationFlow.
    name: []const u8,

    /// The source configurations for DataIntegrationFlow.
    sources: []const DataIntegrationFlowSource,

    /// The tags of the DataIntegrationFlow to be created
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The target configurations for DataIntegrationFlow.
    target: DataIntegrationFlowTarget,

    /// The transformation configurations for DataIntegrationFlow.
    transformation: DataIntegrationFlowTransformation,

    pub const json_field_names = .{
        .instance_id = "instanceId",
        .name = "name",
        .sources = "sources",
        .tags = "tags",
        .target = "target",
        .transformation = "transformation",
    };
};

pub const CreateDataIntegrationFlowOutput = struct {
    /// The Amazon Web Services Supply Chain instance identifier.
    instance_id: []const u8,

    /// The name of the DataIntegrationFlow created.
    name: []const u8,

    pub const json_field_names = .{
        .instance_id = "instanceId",
        .name = "name",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataIntegrationFlowInput, options: CallOptions) !CreateDataIntegrationFlowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "scn", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataIntegrationFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scn", "SupplyChain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/data-integration/instance/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/data-integration-flows/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sources\":");
    try aws.json.writeValue(@TypeOf(input.sources), input.sources, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"target\":");
    try aws.json.writeValue(@TypeOf(input.target), input.target, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"transformation\":");
    try aws.json.writeValue(@TypeOf(input.transformation), input.transformation, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataIntegrationFlowOutput {
    var result: CreateDataIntegrationFlowOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDataIntegrationFlowOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
