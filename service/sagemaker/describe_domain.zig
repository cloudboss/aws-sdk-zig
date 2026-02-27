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
const DomainStatus = @import("domain_status.zig").DomainStatus;
const TagPropagation = @import("tag_propagation.zig").TagPropagation;

pub const DescribeDomainInput = struct {
    /// The domain ID.
    domain_id: []const u8,

    pub const json_field_names = .{
        .domain_id = "DomainId",
    };
};

pub const DescribeDomainOutput = struct {
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
    /// provided.
    app_security_group_management: ?AppSecurityGroupManagement = null,

    /// The domain's authentication mode.
    auth_mode: ?AuthMode = null,

    /// The creation time.
    creation_time: ?i64 = null,

    /// The default settings for shared spaces that users create in the domain.
    default_space_settings: ?DefaultSpaceSettings = null,

    /// Settings which are applied to UserProfiles in this domain if settings are
    /// not explicitly specified in a given UserProfile.
    default_user_settings: ?UserSettings = null,

    /// The domain's Amazon Resource Name (ARN).
    domain_arn: ?[]const u8 = null,

    /// The domain ID.
    domain_id: ?[]const u8 = null,

    /// The domain name.
    domain_name: ?[]const u8 = null,

    /// A collection of `Domain` settings.
    domain_settings: ?DomainSettings = null,

    /// The failure reason.
    failure_reason: ?[]const u8 = null,

    /// The ID of the Amazon Elastic File System managed by this Domain.
    home_efs_file_system_id: ?[]const u8 = null,

    /// Use `KmsKeyId`.
    home_efs_file_system_kms_key_id: ?[]const u8 = null,

    /// The Amazon Web Services KMS customer managed key used to encrypt the EFS
    /// volume attached to the domain.
    kms_key_id: ?[]const u8 = null,

    /// The last modified time.
    last_modified_time: ?i64 = null,

    /// The ID of the security group that authorizes traffic between the
    /// `RSessionGateway` apps and the `RStudioServerPro` app.
    security_group_id_for_domain_boundary: ?[]const u8 = null,

    /// The ARN of the application managed by SageMaker AI in IAM Identity Center.
    /// This value is only returned for domains created after October 1, 2023.
    single_sign_on_application_arn: ?[]const u8 = null,

    /// The IAM Identity Center managed application instance ID.
    single_sign_on_managed_application_instance_id: ?[]const u8 = null,

    /// The status.
    status: ?DomainStatus = null,

    /// The VPC subnets that the domain uses for communication.
    subnet_ids: ?[]const []const u8 = null,

    /// Indicates whether custom tag propagation is supported for the domain.
    tag_propagation: ?TagPropagation = null,

    /// The domain's URL.
    url: ?[]const u8 = null,

    /// The ID of the Amazon Virtual Private Cloud (VPC) that the domain uses for
    /// communication.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_network_access_type = "AppNetworkAccessType",
        .app_security_group_management = "AppSecurityGroupManagement",
        .auth_mode = "AuthMode",
        .creation_time = "CreationTime",
        .default_space_settings = "DefaultSpaceSettings",
        .default_user_settings = "DefaultUserSettings",
        .domain_arn = "DomainArn",
        .domain_id = "DomainId",
        .domain_name = "DomainName",
        .domain_settings = "DomainSettings",
        .failure_reason = "FailureReason",
        .home_efs_file_system_id = "HomeEfsFileSystemId",
        .home_efs_file_system_kms_key_id = "HomeEfsFileSystemKmsKeyId",
        .kms_key_id = "KmsKeyId",
        .last_modified_time = "LastModifiedTime",
        .security_group_id_for_domain_boundary = "SecurityGroupIdForDomainBoundary",
        .single_sign_on_application_arn = "SingleSignOnApplicationArn",
        .single_sign_on_managed_application_instance_id = "SingleSignOnManagedApplicationInstanceId",
        .status = "Status",
        .subnet_ids = "SubnetIds",
        .tag_propagation = "TagPropagation",
        .url = "Url",
        .vpc_id = "VpcId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDomainInput, options: Options) !DescribeDomainOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeDomainInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.DescribeDomain");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeDomainOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDomainOutput, body, alloc);
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
