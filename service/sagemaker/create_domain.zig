const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AppNetworkAccessType = @import("app_network_access_type.zig").AppNetworkAccessType;
const AppSecurityGroupManagement = @import("app_security_group_management.zig").AppSecurityGroupManagement;
const AuthMode = @import("auth_mode.zig").AuthMode;
const DefaultSpaceSettings = @import("default_space_settings.zig").DefaultSpaceSettings;
const UserSettings = @import("user_settings.zig").UserSettings;
const DomainSettings = @import("domain_settings.zig").DomainSettings;
const TagPropagation = @import("tag_propagation.zig").TagPropagation;
const Tag = @import("tag.zig").Tag;

pub const CreateDomainInput = struct {
    /// Specifies the VPC used for non-EFS traffic. The default value is
    /// `PublicInternetOnly`.
    ///
    /// * `PublicInternetOnly` - Non-EFS traffic is through a VPC managed by Amazon
    ///   SageMaker AI, which allows direct internet access
    /// * `VpcOnly` - All traffic is through the specified VPC and subnets
    app_network_access_type: ?AppNetworkAccessType = null,

    /// The entity that creates and manages the required security groups for
    /// inter-app communication in `VPCOnly` mode. Required when
    /// `CreateDomain.AppNetworkAccessType` is `VPCOnly` and
    /// `DomainSettings.RStudioServerProDomainSettings.DomainExecutionRoleArn` is
    /// provided. If setting up the domain for use with RStudio, this value must be
    /// set to `Service`.
    app_security_group_management: ?AppSecurityGroupManagement = null,

    /// The mode of authentication that members use to access the domain.
    auth_mode: AuthMode,

    /// The default settings for shared spaces that users create in the domain.
    default_space_settings: ?DefaultSpaceSettings = null,

    /// The default settings to use to create a user profile when `UserSettings`
    /// isn't specified in the call to the `CreateUserProfile` API.
    ///
    /// `SecurityGroups` is aggregated when specified in both calls. For all other
    /// settings in `UserSettings`, the values specified in `CreateUserProfile` take
    /// precedence over those specified in `CreateDomain`.
    default_user_settings: UserSettings,

    /// A name for the domain.
    domain_name: []const u8,

    /// A collection of `Domain` settings.
    domain_settings: ?DomainSettings = null,

    /// Use `KmsKeyId`.
    home_efs_file_system_kms_key_id: ?[]const u8 = null,

    /// SageMaker AI uses Amazon Web Services KMS to encrypt EFS and EBS volumes
    /// attached to the domain with an Amazon Web Services managed key by default.
    /// For more control, specify a customer managed key.
    kms_key_id: ?[]const u8 = null,

    /// The VPC subnets that the domain uses for communication.
    ///
    /// The field is optional when the `AppNetworkAccessType` parameter is set to
    /// `PublicInternetOnly` for domains created from Amazon SageMaker Unified
    /// Studio.
    subnet_ids: ?[]const []const u8 = null,

    /// Indicates whether custom tag propagation is supported for the domain.
    /// Defaults to `DISABLED`.
    tag_propagation: ?TagPropagation = null,

    /// Tags to associated with the Domain. Each tag consists of a key and an
    /// optional value. Tag keys must be unique per resource. Tags are searchable
    /// using the `Search` API.
    ///
    /// Tags that you specify for the Domain are also added to all Apps that the
    /// Domain launches.
    tags: ?[]const Tag = null,

    /// The ID of the Amazon Virtual Private Cloud (VPC) that the domain uses for
    /// communication.
    ///
    /// The field is optional when the `AppNetworkAccessType` parameter is set to
    /// `PublicInternetOnly` for domains created from Amazon SageMaker Unified
    /// Studio.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_network_access_type = "AppNetworkAccessType",
        .app_security_group_management = "AppSecurityGroupManagement",
        .auth_mode = "AuthMode",
        .default_space_settings = "DefaultSpaceSettings",
        .default_user_settings = "DefaultUserSettings",
        .domain_name = "DomainName",
        .domain_settings = "DomainSettings",
        .home_efs_file_system_kms_key_id = "HomeEfsFileSystemKmsKeyId",
        .kms_key_id = "KmsKeyId",
        .subnet_ids = "SubnetIds",
        .tag_propagation = "TagPropagation",
        .tags = "Tags",
        .vpc_id = "VpcId",
    };
};

pub const CreateDomainOutput = struct {
    /// The Amazon Resource Name (ARN) of the created domain.
    domain_arn: ?[]const u8 = null,

    /// The ID of the created domain.
    domain_id: ?[]const u8 = null,

    /// The URL to the created domain.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_arn = "DomainArn",
        .domain_id = "DomainId",
        .url = "Url",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDomainInput, options: Options) !CreateDomainOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateDomainInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.CreateDomain");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateDomainOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDomainOutput, body, alloc);
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
