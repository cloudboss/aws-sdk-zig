const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DeploymentUpdateType = @import("deployment_update_type.zig").DeploymentUpdateType;
const RepositoryBranchInput = @import("repository_branch_input.zig").RepositoryBranchInput;
const Environment = @import("environment.zig").Environment;

pub const UpdateEnvironmentInput = struct {
    /// The Amazon Resource Name (ARN) of the IAM service role that allows Proton to
    /// provision infrastructure using CodeBuild-based provisioning on your
    /// behalf.
    codebuild_role_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM service role that Proton uses when
    /// provisioning directly defined components in this environment. It
    /// determines the scope of infrastructure that a component can provision.
    ///
    /// The environment must have a `componentRoleArn` to allow directly defined
    /// components to be associated with the environment.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    component_role_arn: ?[]const u8 = null,

    /// There are four modes for updating an environment. The `deploymentType` field
    /// defines the mode.
    ///
    /// `NONE`
    ///
    /// In this mode, a deployment *doesn't* occur. Only the requested metadata
    /// parameters are updated.
    ///
    /// `CURRENT_VERSION`
    ///
    /// In this mode, the environment is deployed and updated with the new spec that
    /// you provide. Only requested parameters are updated.
    /// *Don’t* include major or minor version parameters when you use this
    /// `deployment-type`.
    ///
    /// `MINOR_VERSION`
    ///
    /// In this mode, the environment is deployed and updated with the published,
    /// recommended (latest) minor version of the current major version in
    /// use, by default. You can also specify a different minor version of the
    /// current major version in use.
    ///
    /// `MAJOR_VERSION`
    ///
    /// In this mode, the environment is deployed and updated with the published,
    /// recommended (latest) major and minor version of the current template,
    /// by default. You can also specify a different major version that is higher
    /// than the major version in use and a minor version (optional).
    deployment_type: DeploymentUpdateType,

    /// A description of the environment update.
    description: ?[]const u8 = null,

    /// The ID of the environment account connection.
    ///
    /// You can only update to a new environment account connection if it was
    /// created in the same environment account that the current environment account
    /// connection was created in and is associated with the current environment.
    environment_account_connection_id: ?[]const u8 = null,

    /// The name of the environment to update.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the Proton service role that allows Proton
    /// to make API calls to other services your behalf.
    proton_service_role_arn: ?[]const u8 = null,

    /// The linked repository that you use to host your rendered infrastructure
    /// templates for self-managed provisioning. A linked repository is a repository
    /// that has been registered with Proton. For more information, see
    /// CreateRepository.
    provisioning_repository: ?RepositoryBranchInput = null,

    /// The formatted specification that defines the update.
    spec: ?[]const u8 = null,

    /// The major version of the environment to update.
    template_major_version: ?[]const u8 = null,

    /// The minor version of the environment to update.
    template_minor_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .codebuild_role_arn = "codebuildRoleArn",
        .component_role_arn = "componentRoleArn",
        .deployment_type = "deploymentType",
        .description = "description",
        .environment_account_connection_id = "environmentAccountConnectionId",
        .name = "name",
        .proton_service_role_arn = "protonServiceRoleArn",
        .provisioning_repository = "provisioningRepository",
        .spec = "spec",
        .template_major_version = "templateMajorVersion",
        .template_minor_version = "templateMinorVersion",
    };
};

pub const UpdateEnvironmentOutput = struct {
    /// The environment detail data that's returned by Proton.
    environment: ?Environment = null,

    pub const json_field_names = .{
        .environment = "environment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEnvironmentInput, options: CallOptions) !UpdateEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "awsproton20200720");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.UpdateEnvironment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEnvironmentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateEnvironmentOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
