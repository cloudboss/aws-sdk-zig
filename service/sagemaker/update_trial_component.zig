const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TrialComponentArtifact = @import("trial_component_artifact.zig").TrialComponentArtifact;
const TrialComponentParameterValue = @import("trial_component_parameter_value.zig").TrialComponentParameterValue;
const TrialComponentStatus = @import("trial_component_status.zig").TrialComponentStatus;

pub const UpdateTrialComponentInput = struct {
    /// The name of the component as displayed. The name doesn't need to be unique.
    /// If `DisplayName` isn't specified, `TrialComponentName` is displayed.
    display_name: ?[]const u8 = null,

    /// When the component ended.
    end_time: ?i64 = null,

    /// Replaces all of the component's input artifacts with the specified artifacts
    /// or adds new input artifacts. Existing input artifacts are replaced if the
    /// trial component is updated with an identical input artifact key.
    input_artifacts: ?[]const aws.map.MapEntry(TrialComponentArtifact) = null,

    /// The input artifacts to remove from the component.
    input_artifacts_to_remove: ?[]const []const u8 = null,

    /// Replaces all of the component's output artifacts with the specified
    /// artifacts or adds new output artifacts. Existing output artifacts are
    /// replaced if the trial component is updated with an identical output artifact
    /// key.
    output_artifacts: ?[]const aws.map.MapEntry(TrialComponentArtifact) = null,

    /// The output artifacts to remove from the component.
    output_artifacts_to_remove: ?[]const []const u8 = null,

    /// Replaces all of the component's hyperparameters with the specified
    /// hyperparameters or add new hyperparameters. Existing hyperparameters are
    /// replaced if the trial component is updated with an identical hyperparameter
    /// key.
    parameters: ?[]const aws.map.MapEntry(TrialComponentParameterValue) = null,

    /// The hyperparameters to remove from the component.
    parameters_to_remove: ?[]const []const u8 = null,

    /// When the component started.
    start_time: ?i64 = null,

    /// The new status of the component.
    status: ?TrialComponentStatus = null,

    /// The name of the component to update.
    trial_component_name: []const u8,

    pub const json_field_names = .{
        .display_name = "DisplayName",
        .end_time = "EndTime",
        .input_artifacts = "InputArtifacts",
        .input_artifacts_to_remove = "InputArtifactsToRemove",
        .output_artifacts = "OutputArtifacts",
        .output_artifacts_to_remove = "OutputArtifactsToRemove",
        .parameters = "Parameters",
        .parameters_to_remove = "ParametersToRemove",
        .start_time = "StartTime",
        .status = "Status",
        .trial_component_name = "TrialComponentName",
    };
};

pub const UpdateTrialComponentOutput = struct {
    /// The Amazon Resource Name (ARN) of the trial component.
    trial_component_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .trial_component_arn = "TrialComponentArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTrialComponentInput, options: Options) !UpdateTrialComponentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateTrialComponentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.UpdateTrialComponent");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateTrialComponentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateTrialComponentOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
