const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const RepositoryBranchInput = @import("repository_branch_input.zig").RepositoryBranchInput;
const Tag = @import("tag.zig").Tag;
const Environment = @import("environment.zig").Environment;

pub const CreateEnvironmentInput = struct {
    /// The Amazon Resource Name (ARN) of the IAM service role that allows Proton to
    /// provision infrastructure using CodeBuild-based provisioning on your
    /// behalf.
    ///
    /// To use CodeBuild-based provisioning for the environment or for any service
    /// instance running in the environment, specify either the
    /// `environmentAccountConnectionId` or `codebuildRoleArn` parameter.
    codebuild_role_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM service role that Proton uses when
    /// provisioning directly defined components in this environment. It
    /// determines the scope of infrastructure that a component can provision.
    ///
    /// You must specify `componentRoleArn` to allow directly defined components to
    /// be associated with this environment.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    component_role_arn: ?[]const u8 = null,

    /// A description of the environment that's being created and deployed.
    description: ?[]const u8 = null,

    /// The ID of the environment account connection that you provide if you're
    /// provisioning your environment infrastructure resources to an environment
    /// account. For more information, see [Environment account
    /// connections](https://docs.aws.amazon.com/proton/latest/userguide/ag-env-account-connections.html) in the *Proton User guide*.
    ///
    /// To use Amazon Web Services-managed provisioning for the environment, specify
    /// either the `environmentAccountConnectionId` or
    /// `protonServiceRoleArn` parameter and omit the `provisioningRepository`
    /// parameter.
    environment_account_connection_id: ?[]const u8 = null,

    /// The name of the environment.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the Proton service role that allows Proton
    /// to make calls to other services on your behalf.
    ///
    /// To use Amazon Web Services-managed provisioning for the environment, specify
    /// either the `environmentAccountConnectionId` or
    /// `protonServiceRoleArn` parameter and omit the `provisioningRepository`
    /// parameter.
    proton_service_role_arn: ?[]const u8 = null,

    /// The linked repository that you use to host your rendered infrastructure
    /// templates for self-managed provisioning. A linked repository is a repository
    /// that has been registered with Proton. For more information, see
    /// CreateRepository.
    ///
    /// To use self-managed provisioning for the environment, specify this parameter
    /// and omit the `environmentAccountConnectionId` and
    /// `protonServiceRoleArn` parameters.
    provisioning_repository: ?RepositoryBranchInput = null,

    /// A YAML formatted string that provides inputs as defined in the environment
    /// template bundle schema file. For more information, see
    /// [Environments](https://docs.aws.amazon.com/proton/latest/userguide/ag-environments.html) in the *Proton User
    /// Guide*.
    spec: []const u8,

    /// An optional list of metadata items that you can associate with the Proton
    /// environment. A tag is a key-value pair.
    ///
    /// For more information, see [Proton resources and
    /// tagging](https://docs.aws.amazon.com/proton/latest/userguide/resources.html)
    /// in the
    /// *Proton User Guide*.
    tags: ?[]const Tag = null,

    /// The major version of the environment template.
    template_major_version: []const u8,

    /// The minor version of the environment template.
    template_minor_version: ?[]const u8 = null,

    /// The name of the environment template. For more information, see [Environment
    /// Templates](https://docs.aws.amazon.com/proton/latest/userguide/ag-templates.html) in the *Proton User Guide*.
    template_name: []const u8,

    pub const json_field_names = .{
        .codebuild_role_arn = "codebuildRoleArn",
        .component_role_arn = "componentRoleArn",
        .description = "description",
        .environment_account_connection_id = "environmentAccountConnectionId",
        .name = "name",
        .proton_service_role_arn = "protonServiceRoleArn",
        .provisioning_repository = "provisioningRepository",
        .spec = "spec",
        .tags = "tags",
        .template_major_version = "templateMajorVersion",
        .template_minor_version = "templateMinorVersion",
        .template_name = "templateName",
    };
};

pub const CreateEnvironmentOutput = struct {
    /// The environment detail data that's returned by Proton.
    environment: ?Environment = null,

    pub const json_field_names = .{
        .environment = "environment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentInput, options: CallOptions) !CreateEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsproton20200720", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.CreateEnvironment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateEnvironmentOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?errors.InternalServerException = aws.json.parseJsonObject(errors.InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
