const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DefinitionDocument = @import("definition_document.zig").DefinitionDocument;
const MetricsConfiguration = @import("metrics_configuration.zig").MetricsConfiguration;
const Tag = @import("tag.zig").Tag;
const DeploymentTarget = @import("deployment_target.zig").DeploymentTarget;
const SystemInstanceSummary = @import("system_instance_summary.zig").SystemInstanceSummary;

pub const CreateSystemInstanceInput = struct {
    definition: DefinitionDocument,

    /// The ARN of the IAM role that AWS IoT Things Graph will assume when it
    /// executes the flow. This role must have
    /// read and write access to AWS Lambda and AWS IoT and any other AWS services
    /// that the flow uses when it executes. This
    /// value is required if the value of the `target` parameter is `CLOUD`.
    flow_actions_role_arn: ?[]const u8 = null,

    /// The name of the Greengrass group where the system instance will be deployed.
    /// This value is required if
    /// the value of the `target` parameter is `GREENGRASS`.
    greengrass_group_name: ?[]const u8 = null,

    metrics_configuration: ?MetricsConfiguration = null,

    /// The name of the Amazon Simple Storage Service bucket that will be used to
    /// store and deploy the system instance's resource file. This value is required
    /// if
    /// the value of the `target` parameter is `GREENGRASS`.
    s_3_bucket_name: ?[]const u8 = null,

    /// Metadata, consisting of key-value pairs, that can be used to categorize your
    /// system instances.
    tags: ?[]const Tag = null,

    /// The target type of the deployment. Valid values are `GREENGRASS` and
    /// `CLOUD`.
    target: DeploymentTarget,

    pub const json_field_names = .{
        .definition = "definition",
        .flow_actions_role_arn = "flowActionsRoleArn",
        .greengrass_group_name = "greengrassGroupName",
        .metrics_configuration = "metricsConfiguration",
        .s_3_bucket_name = "s3BucketName",
        .tags = "tags",
        .target = "target",
    };
};

pub const CreateSystemInstanceOutput = struct {
    /// The summary object that describes the new system instance.
    summary: ?SystemInstanceSummary = null,

    pub const json_field_names = .{
        .summary = "summary",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSystemInstanceInput, options: Options) !CreateSystemInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotthingsgraph");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateSystemInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotthingsgraph", "IoTThingsGraph", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "IotThingsGraphFrontEndService.CreateSystemInstance");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateSystemInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSystemInstanceOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
