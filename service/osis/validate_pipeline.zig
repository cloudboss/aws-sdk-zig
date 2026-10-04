const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ValidationMessage = @import("validation_message.zig").ValidationMessage;

pub const ValidatePipelineInput = struct {
    /// The pipeline configuration in YAML format. The command accepts the pipeline
    /// configuration as
    /// a string or within a .yaml file. If you provide the configuration as a
    /// string, each new line must
    /// be escaped with `\n`.
    pipeline_configuration_body: []const u8,

    pub const json_field_names = .{
        .pipeline_configuration_body = "PipelineConfigurationBody",
    };
};

pub const ValidatePipelineOutput = struct {
    /// A list of errors if the configuration is invalid.
    errors: ?[]const ValidationMessage = null,

    /// A boolean indicating whether or not the pipeline configuration is valid.
    is_valid: ?bool = null,

    pub const json_field_names = .{
        .errors = "Errors",
        .is_valid = "isValid",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ValidatePipelineInput, options: CallOptions) !ValidatePipelineOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "osis", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ValidatePipelineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("osis", "OSIS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2022-01-01/osis/validatePipeline";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PipelineConfigurationBody\":");
    try aws.json.writeValue(@TypeOf(input.pipeline_configuration_body), input.pipeline_configuration_body, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ValidatePipelineOutput {
    var result: ValidatePipelineOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ValidatePipelineOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
