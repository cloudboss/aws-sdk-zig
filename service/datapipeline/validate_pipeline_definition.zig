const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParameterObject = @import("parameter_object.zig").ParameterObject;
const ParameterValue = @import("parameter_value.zig").ParameterValue;
const PipelineObject = @import("pipeline_object.zig").PipelineObject;
const ValidationError = @import("validation_error.zig").ValidationError;
const ValidationWarning = @import("validation_warning.zig").ValidationWarning;

pub const ValidatePipelineDefinitionInput = struct {
    /// The parameter objects used with the pipeline.
    parameter_objects: ?[]const ParameterObject = null,

    /// The parameter values used with the pipeline.
    parameter_values: ?[]const ParameterValue = null,

    /// The ID of the pipeline.
    pipeline_id: []const u8,

    /// The objects that define the pipeline changes to validate against the
    /// pipeline.
    pipeline_objects: []const PipelineObject,

    pub const json_field_names = .{
        .parameter_objects = "parameterObjects",
        .parameter_values = "parameterValues",
        .pipeline_id = "pipelineId",
        .pipeline_objects = "pipelineObjects",
    };
};

pub const ValidatePipelineDefinitionOutput = struct {
    /// Indicates whether there were validation errors.
    errored: ?bool = null,

    /// Any validation errors that were found.
    validation_errors: ?[]const ValidationError = null,

    /// Any validation warnings that were found.
    validation_warnings: ?[]const ValidationWarning = null,

    pub const json_field_names = .{
        .errored = "errored",
        .validation_errors = "validationErrors",
        .validation_warnings = "validationWarnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ValidatePipelineDefinitionInput, options: CallOptions) !ValidatePipelineDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datapipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ValidatePipelineDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datapipeline", "Data Pipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DataPipeline.ValidatePipelineDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ValidatePipelineDefinitionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ValidatePipelineDefinitionOutput, body, allocator);
}
