const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AuthMode = @import("auth_mode.zig").AuthMode;
const IdcUserAssignment = @import("idc_user_assignment.zig").IdcUserAssignment;
const Tag = @import("tag.zig").Tag;

pub const CreateStudioInput = struct {
    /// Specifies whether the Studio authenticates users using IAM or IAM Identity
    /// Center.
    auth_mode: AuthMode,

    /// The Amazon S3 location to back up Amazon EMR Studio Workspaces and
    /// notebook files.
    default_s3_location: []const u8,

    /// A detailed description of the Amazon EMR Studio.
    description: ?[]const u8 = null,

    /// The KMS key identifier (ARN) used to encrypt Amazon EMR Studio workspace and
    /// notebook files when backed up to Amazon S3.
    encryption_key_arn: ?[]const u8 = null,

    /// The ID of the Amazon EMR Studio Engine security group. The Engine security
    /// group
    /// allows inbound network traffic from the Workspace security group, and it
    /// must be in the
    /// same VPC specified by `VpcId`.
    engine_security_group_id: []const u8,

    /// The ARN of the IAM Identity Center instance to create the Studio
    /// application.
    idc_instance_arn: ?[]const u8 = null,

    /// Specifies whether IAM Identity Center user assignment is `REQUIRED` or
    /// `OPTIONAL`. If the value is set to `REQUIRED`, users must be explicitly
    /// assigned to the Studio application to access the Studio.
    idc_user_assignment: ?IdcUserAssignment = null,

    /// The authentication endpoint of your identity provider (IdP). Specify this
    /// value when you
    /// use IAM authentication and want to let federated users log in to a Studio
    /// with the Studio URL and credentials from your IdP. Amazon EMR Studio
    /// redirects
    /// users to this endpoint to enter credentials.
    idp_auth_url: ?[]const u8 = null,

    /// The name that your identity provider (IdP) uses for its `RelayState`
    /// parameter. For example, `RelayState` or `TargetSource`. Specify this
    /// value when you use IAM authentication and want to let federated users log in
    /// to a Studio using the Studio URL. The `RelayState` parameter differs by
    /// IdP.
    idp_relay_state_parameter_name: ?[]const u8 = null,

    /// A descriptive name for the Amazon EMR Studio.
    name: []const u8,

    /// The IAM role that the Amazon EMR Studio assumes. The service role
    /// provides a way for Amazon EMR Studio to interoperate with other Amazon Web
    /// Services
    /// services.
    service_role: []const u8,

    /// A list of subnet IDs to associate with the Amazon EMR Studio. A Studio can
    /// have
    /// a maximum of 5 subnets. The subnets must belong to the VPC specified by
    /// `VpcId`.
    /// Studio users can create a Workspace in any of the specified subnets.
    subnet_ids: []const []const u8,

    /// A list of tags to associate with the Amazon EMR Studio. Tags are
    /// user-defined
    /// key-value pairs that consist of a required key string with a maximum of 128
    /// characters, and
    /// an optional value string with a maximum of 256 characters.
    tags: ?[]const Tag = null,

    /// A Boolean indicating whether to enable Trusted identity propagation for the
    /// Studio. The default value is `false`.
    trusted_identity_propagation_enabled: ?bool = null,

    /// The IAM user role that users and groups assume when logged in to an
    /// Amazon EMR Studio. Only specify a `UserRole` when you use IAM Identity
    /// Center authentication. The permissions attached to the `UserRole` can be
    /// scoped down for each user or group using session policies.
    user_role: ?[]const u8 = null,

    /// The ID of the Amazon Virtual Private Cloud (Amazon VPC) to associate with
    /// the
    /// Studio.
    vpc_id: []const u8,

    /// The ID of the Amazon EMR Studio Workspace security group. The Workspace
    /// security
    /// group allows outbound network traffic to resources in the Engine security
    /// group, and it
    /// must be in the same VPC specified by `VpcId`.
    workspace_security_group_id: []const u8,

    pub const json_field_names = .{
        .auth_mode = "AuthMode",
        .default_s3_location = "DefaultS3Location",
        .description = "Description",
        .encryption_key_arn = "EncryptionKeyArn",
        .engine_security_group_id = "EngineSecurityGroupId",
        .idc_instance_arn = "IdcInstanceArn",
        .idc_user_assignment = "IdcUserAssignment",
        .idp_auth_url = "IdpAuthUrl",
        .idp_relay_state_parameter_name = "IdpRelayStateParameterName",
        .name = "Name",
        .service_role = "ServiceRole",
        .subnet_ids = "SubnetIds",
        .tags = "Tags",
        .trusted_identity_propagation_enabled = "TrustedIdentityPropagationEnabled",
        .user_role = "UserRole",
        .vpc_id = "VpcId",
        .workspace_security_group_id = "WorkspaceSecurityGroupId",
    };
};

pub const CreateStudioOutput = struct {
    /// The ID of the Amazon EMR Studio.
    studio_id: ?[]const u8 = null,

    /// The unique Studio access URL.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .studio_id = "StudioId",
        .url = "Url",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStudioInput, options: Options) !CreateStudioOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "emr");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStudioInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("emr", "EMR", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.CreateStudio");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStudioOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateStudioOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
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
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
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
