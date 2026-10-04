const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputationModelConfiguration = @import("computation_model_configuration.zig").ComputationModelConfiguration;
const ComputationModelDataBindingValue = @import("computation_model_data_binding_value.zig").ComputationModelDataBindingValue;
const ComputationModelStatus = @import("computation_model_status.zig").ComputationModelStatus;

pub const UpdateComputationModelInput = struct {
    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the
    /// request. Don't reuse this client token if a new idempotent request is
    /// required.
    client_token: ?[]const u8 = null,

    /// The configuration for the computation model.
    computation_model_configuration: ComputationModelConfiguration,

    /// The data binding for the computation model. Key is a variable name defined
    /// in configuration.
    /// Value is a `ComputationModelDataBindingValue` referenced by the variable.
    computation_model_data_binding: []const aws.map.MapEntry(ComputationModelDataBindingValue),

    /// The description of the computation model.
    computation_model_description: ?[]const u8 = null,

    /// The ID of the computation model.
    computation_model_id: []const u8,

    /// The name of the computation model.
    computation_model_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .computation_model_configuration = "computationModelConfiguration",
        .computation_model_data_binding = "computationModelDataBinding",
        .computation_model_description = "computationModelDescription",
        .computation_model_id = "computationModelId",
        .computation_model_name = "computationModelName",
    };
};

pub const UpdateComputationModelOutput = struct {
    /// The status of the computation model. It contains a state (UPDATING after
    /// successfully
    /// calling this operation) and an error message if any.
    computation_model_status: ?ComputationModelStatus = null,

    pub const json_field_names = .{
        .computation_model_status = "computationModelStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateComputationModelInput, options: CallOptions) !UpdateComputationModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateComputationModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/computation-models/");
    try path_buf.appendSlice(allocator, input.computation_model_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"computationModelConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.computation_model_configuration), input.computation_model_configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"computationModelDataBinding\":");
    try aws.json.writeValue(@TypeOf(input.computation_model_data_binding), input.computation_model_data_binding, allocator, &body_buf);
    has_prev = true;
    if (input.computation_model_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"computationModelDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"computationModelName\":");
    try aws.json.writeValue(@TypeOf(input.computation_model_name), input.computation_model_name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateComputationModelOutput {
    var result: UpdateComputationModelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateComputationModelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
