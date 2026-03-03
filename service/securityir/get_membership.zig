const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const CustomerType = @import("customer_type.zig").CustomerType;
const IncidentResponder = @import("incident_responder.zig").IncidentResponder;
const MembershipAccountsConfigurations = @import("membership_accounts_configurations.zig").MembershipAccountsConfigurations;
const MembershipStatus = @import("membership_status.zig").MembershipStatus;
const OptInFeature = @import("opt_in_feature.zig").OptInFeature;
const AwsRegion = @import("aws_region.zig").AwsRegion;

pub const GetMembershipInput = struct {
    /// Required element for GetMembership to identify the membership ID to query.
    membership_id: []const u8,

    pub const json_field_names = .{
        .membership_id = "membershipId",
    };
};

pub const GetMembershipOutput = struct {
    /// Response element for GetMembership that provides the account configured to
    /// manage the membership.
    account_id: ?[]const u8 = null,

    /// Response element for GetMembership that provides the configured membership
    /// type. Options include ` Standalone | Organizations`.
    customer_type: ?CustomerType = null,

    /// Response element for GetMembership that provides the configured membership
    /// incident response team members.
    incident_response_team: ?[]const IncidentResponder = null,

    /// The `membershipAccountsConfigurations` field contains the configuration
    /// details for member accounts within the Amazon Web Services Organizations
    /// membership structure.
    ///
    /// This field returns a structure containing information about:
    ///
    /// * Account configurations for member accounts
    /// * Membership settings and preferences
    /// * Account-level permissions and roles
    membership_accounts_configurations: ?MembershipAccountsConfigurations = null,

    /// Response element for GetMembership that provides the configured membership
    /// activation timestamp.
    membership_activation_timestamp: ?i64 = null,

    /// Response element for GetMembership that provides the membership ARN.
    membership_arn: ?[]const u8 = null,

    /// Response element for GetMembership that provides the configured membership
    /// name deactivation timestamp.
    membership_deactivation_timestamp: ?i64 = null,

    /// Response element for GetMembership that provides the queried membership ID.
    membership_id: []const u8,

    /// Response element for GetMembership that provides the configured membership
    /// name.
    membership_name: ?[]const u8 = null,

    /// Response element for GetMembership that provides the current membership
    /// status.
    membership_status: ?MembershipStatus = null,

    /// Response element for GetMembership that provides the number of accounts in
    /// the membership.
    number_of_accounts_covered: ?i64 = null,

    /// Response element for GetMembership that provides the if opt-in features have
    /// been enabled.
    opt_in_features: ?[]const OptInFeature = null,

    /// Response element for GetMembership that provides the region configured to
    /// manage the membership.
    region: ?AwsRegion = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .customer_type = "customerType",
        .incident_response_team = "incidentResponseTeam",
        .membership_accounts_configurations = "membershipAccountsConfigurations",
        .membership_activation_timestamp = "membershipActivationTimestamp",
        .membership_arn = "membershipArn",
        .membership_deactivation_timestamp = "membershipDeactivationTimestamp",
        .membership_id = "membershipId",
        .membership_name = "membershipName",
        .membership_status = "membershipStatus",
        .number_of_accounts_covered = "numberOfAccountsCovered",
        .opt_in_features = "optInFeatures",
        .region = "region",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMembershipInput, options: Options) !GetMembershipOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "securityir");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMembershipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityir", "Security IR", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v1/membership/");
    try path_buf.appendSlice(allocator, input.membership_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMembershipOutput {
    var result: GetMembershipOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetMembershipOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InvalidTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "SecurityIncidentResponseNotActiveException")) {
        return .{ .arena = arena, .kind = .{ .security_incident_response_not_active_exception = .{
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
