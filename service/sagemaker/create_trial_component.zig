const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const TrialComponentArtifact = @import("trial_component_artifact.zig").TrialComponentArtifact;
const MetadataProperties = @import("metadata_properties.zig").MetadataProperties;
const TrialComponentParameterValue = @import("trial_component_parameter_value.zig").TrialComponentParameterValue;
const TrialComponentStatus = @import("trial_component_status.zig").TrialComponentStatus;
const Tag = @import("tag.zig").Tag;

pub const CreateTrialComponentInput = struct {
    /// The name of the component as displayed. The name doesn't need to be unique.
    /// If `DisplayName` isn't specified, `TrialComponentName` is displayed.
    display_name: ?[]const u8 = null,

    /// When the component ended.
    end_time: ?i64 = null,

    /// The input artifacts for the component. Examples of input artifacts are
    /// datasets, algorithms, hyperparameters, source code, and instance types.
    input_artifacts: ?[]const aws.map.MapEntry(TrialComponentArtifact) = null,

    metadata_properties: ?MetadataProperties = null,

    /// The output artifacts for the component. Examples of output artifacts are
    /// metrics, snapshots, logs, and images.
    output_artifacts: ?[]const aws.map.MapEntry(TrialComponentArtifact) = null,

    /// The hyperparameters for the component.
    parameters: ?[]const aws.map.MapEntry(TrialComponentParameterValue) = null,

    /// When the component started.
    start_time: ?i64 = null,

    /// The status of the component. States include:
    ///
    /// * InProgress
    /// * Completed
    /// * Failed
    status: ?TrialComponentStatus = null,

    /// A list of tags to associate with the component. You can use
    /// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API to search on the tags.
    tags: ?[]const Tag = null,

    /// The name of the component. The name must be unique in your Amazon Web
    /// Services account and is not case-sensitive.
    trial_component_name: []const u8,

    pub const json_field_names = .{
        .display_name = "DisplayName",
        .end_time = "EndTime",
        .input_artifacts = "InputArtifacts",
        .metadata_properties = "MetadataProperties",
        .output_artifacts = "OutputArtifacts",
        .parameters = "Parameters",
        .start_time = "StartTime",
        .status = "Status",
        .tags = "Tags",
        .trial_component_name = "TrialComponentName",
    };
};

pub const CreateTrialComponentOutput = struct {
    /// The Amazon Resource Name (ARN) of the trial component.
    trial_component_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .trial_component_arn = "TrialComponentArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrialComponentInput, options: Options) !CreateTrialComponentOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrialComponentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateTrialComponent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrialComponentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTrialComponentOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
