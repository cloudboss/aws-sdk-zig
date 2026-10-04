const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LabelsInputConfiguration = @import("labels_input_configuration.zig").LabelsInputConfiguration;
const ModelDiagnosticsOutputConfiguration = @import("model_diagnostics_output_configuration.zig").ModelDiagnosticsOutputConfiguration;

pub const UpdateModelInput = struct {
    labels_input_configuration: ?LabelsInputConfiguration = null,

    /// The Amazon S3 location where you want Amazon Lookout for Equipment to save
    /// the pointwise model diagnostics for the model.
    /// You must also specify the `RoleArn` request parameter.
    model_diagnostics_output_configuration: ?ModelDiagnosticsOutputConfiguration = null,

    /// The name of the model to update.
    model_name: []const u8,

    /// The ARN of the model to update.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .labels_input_configuration = "LabelsInputConfiguration",
        .model_diagnostics_output_configuration = "ModelDiagnosticsOutputConfiguration",
        .model_name = "ModelName",
        .role_arn = "RoleArn",
    };
};

pub const UpdateModelOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateModelInput, options: CallOptions) !UpdateModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lookoutequipment", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.UpdateModel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateModelOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
