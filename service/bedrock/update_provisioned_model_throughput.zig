const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateProvisionedModelThroughputInput = struct {
    /// The Amazon Resource Name (ARN) of the new model to associate with this
    /// Provisioned Throughput. You can't specify this field if this Provisioned
    /// Throughput is associated with a base model.
    ///
    /// If this Provisioned Throughput is associated with a custom model, you can
    /// specify one of the following options:
    ///
    /// * The base model from which the custom model was customized.
    /// * Another custom model that was customized from the same base model as the
    ///   custom model.
    desired_model_id: ?[]const u8 = null,

    /// The new name for this Provisioned Throughput.
    desired_provisioned_model_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) or name of the Provisioned Throughput to
    /// update.
    provisioned_model_id: []const u8,

    pub const json_field_names = .{
        .desired_model_id = "desiredModelId",
        .desired_provisioned_model_name = "desiredProvisionedModelName",
        .provisioned_model_id = "provisionedModelId",
    };
};

pub const UpdateProvisionedModelThroughputOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProvisionedModelThroughputInput, options: CallOptions) !UpdateProvisionedModelThroughputOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProvisionedModelThroughputInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/provisioned-model-throughput/");
    try path_buf.appendSlice(allocator, input.provisioned_model_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.desired_model_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"desiredModelId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.desired_provisioned_model_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"desiredProvisionedModelName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProvisionedModelThroughputOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateProvisionedModelThroughputOutput = .{};

    return result;
}
