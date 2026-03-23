const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ConfigurationStatus = @import("configuration_status.zig").ConfigurationStatus;
const Role = @import("role.zig").Role;
const SupportedEmailDomainsStatus = @import("supported_email_domains_status.zig").SupportedEmailDomainsStatus;
const TierLevel = @import("tier_level.zig").TierLevel;
const VanityDomainStatus = @import("vanity_domain_status.zig").VanityDomainStatus;

pub const GetSpaceInput = struct {
    /// The ID of the private re:Post.
    space_id: []const u8,

    pub const json_field_names = .{
        .space_id = "spaceId",
    };
};

pub const GetSpaceOutput = struct {
    application_arn: ?[]const u8 = null,

    /// The ARN of the private re:Post.
    arn: []const u8,

    /// The Identity Center identifier for the Application Instance.
    client_id: []const u8,

    /// The configuration status of the private re:Post.
    configuration_status: ConfigurationStatus,

    /// The content size of the private re:Post.
    content_size: ?i64 = null,

    /// The date when the private re:Post was created.
    create_date_time: i64,

    /// The IAM role that grants permissions to the private re:Post to convert
    /// unanswered questions into AWS support tickets.
    customer_role_arn: ?[]const u8 = null,

    /// The date when the private re:Post was deleted.
    delete_date_time: ?i64 = null,

    /// The description of the private re:Post.
    description: ?[]const u8 = null,

    /// The list of groups that are administrators of the private re:Post.
    group_admins: ?[]const []const u8 = null,

    identity_store_id: ?[]const u8 = null,

    /// The name of the private re:Post.
    name: []const u8,

    /// The AWS generated subdomain of the private re:Post
    random_domain: []const u8,

    /// A map of accessor identifiers and their roles.
    roles: ?[]const aws.map.MapEntry([]const Role) = null,

    /// The unique ID of the private re:Post.
    space_id: []const u8,

    /// The creation or deletion status of the private re:Post.
    status: []const u8,

    /// The storage limit of the private re:Post.
    storage_limit: i64,

    supported_email_domains: ?SupportedEmailDomainsStatus = null,

    /// The pricing tier of the private re:Post.
    tier: TierLevel,

    /// The list of users that are administrators of the private re:Post.
    user_admins: ?[]const []const u8 = null,

    /// The number of users that have onboarded to the private re:Post.
    user_count: ?i32 = null,

    /// The custom AWS KMS key ARN that’s used for the AWS KMS encryption.
    user_kms_key: ?[]const u8 = null,

    /// The custom subdomain that you use to access your private re:Post. All custom
    /// subdomains must be approved by AWS before use.
    vanity_domain: []const u8,

    /// The approval status of the custom subdomain.
    vanity_domain_status: VanityDomainStatus,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
        .arn = "arn",
        .client_id = "clientId",
        .configuration_status = "configurationStatus",
        .content_size = "contentSize",
        .create_date_time = "createDateTime",
        .customer_role_arn = "customerRoleArn",
        .delete_date_time = "deleteDateTime",
        .description = "description",
        .group_admins = "groupAdmins",
        .identity_store_id = "identityStoreId",
        .name = "name",
        .random_domain = "randomDomain",
        .roles = "roles",
        .space_id = "spaceId",
        .status = "status",
        .storage_limit = "storageLimit",
        .supported_email_domains = "supportedEmailDomains",
        .tier = "tier",
        .user_admins = "userAdmins",
        .user_count = "userCount",
        .user_kms_key = "userKMSKey",
        .vanity_domain = "vanityDomain",
        .vanity_domain_status = "vanityDomainStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSpaceInput, options: CallOptions) !GetSpaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "repostspace");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSpaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("repostspace", "repostspace", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/spaces/");
    try path_buf.appendSlice(allocator, input.space_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSpaceOutput {
    var result: GetSpaceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSpaceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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
