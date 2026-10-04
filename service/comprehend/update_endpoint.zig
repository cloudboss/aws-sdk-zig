const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateEndpointInput = struct {
    /// Data access role ARN to use in case the new model is encrypted with a
    /// customer CMK.
    desired_data_access_role_arn: ?[]const u8 = null,

    /// The desired number of inference units to be used by the model using this
    /// endpoint.
    ///
    /// Each inference unit represents of a throughput of 100 characters per second.
    desired_inference_units: ?i32 = null,

    /// The ARN of the new model to use when updating an existing endpoint.
    desired_model_arn: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the endpoint being updated.
    endpoint_arn: []const u8,

    /// The Amazon Resource Number (ARN) of the flywheel
    flywheel_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .desired_data_access_role_arn = "DesiredDataAccessRoleArn",
        .desired_inference_units = "DesiredInferenceUnits",
        .desired_model_arn = "DesiredModelArn",
        .endpoint_arn = "EndpointArn",
        .flywheel_arn = "FlywheelArn",
    };
};

pub const UpdateEndpointOutput = struct {
    /// The Amazon Resource Number (ARN) of the new model.
    desired_model_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .desired_model_arn = "DesiredModelArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEndpointInput, options: CallOptions) !UpdateEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehend", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehend", "Comprehend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.UpdateEndpoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEndpointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateEndpointOutput, body, allocator);
}
