const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDomainInput, options: CallOptions) !DescribeDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeDomain");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDomainOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDomainOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        const parsed_error: ?errors.ResourceInUse = aws.json.parseJsonObject(errors.ResourceInUse, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        const parsed_error: ?errors.ResourceLimitExceeded = aws.json.parseJsonObject(errors.ResourceLimitExceeded, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        const parsed_error: ?errors.ResourceNotFound = aws.json.parseJsonObject(errors.ResourceNotFound, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found = typed_error } };
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
