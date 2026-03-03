const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Alarms = @import("alarms.zig").Alarms;
const AuthMode = @import("auth_mode.zig").AuthMode;
const ImageLocation = @import("image_location.zig").ImageLocation;
const PortalStatus = @import("portal_status.zig").PortalStatus;
const PortalType = @import("portal_type.zig").PortalType;
const PortalTypeEntry = @import("portal_type_entry.zig").PortalTypeEntry;

pub const DescribePortalInput = struct {
    /// The ID of the portal.
    portal_id: []const u8,

    pub const json_field_names = .{
        .portal_id = "portalId",
    };
};

pub const DescribePortalOutput = struct {
    /// Contains the configuration information of an alarm created in an IoT
    /// SiteWise Monitor portal.
    alarms: ?Alarms = null,

    /// The email address that sends alarm notifications.
    notification_sender_email: ?[]const u8 = null,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the portal, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:portal/${PortalId}`
    portal_arn: []const u8,

    /// The service to use to authenticate users to the portal.
    portal_auth_mode: ?AuthMode = null,

    /// The IAM Identity Center application generated client ID (used with IAM
    /// Identity Center API operations). IoT SiteWise includes
    /// `portalClientId` for only portals that use IAM Identity Center to
    /// authenticate users.
    portal_client_id: []const u8,

    /// The Amazon Web Services administrator's contact email address.
    portal_contact_email: []const u8,

    /// The date the portal was created, in Unix epoch time.
    portal_creation_date: i64,

    /// The portal's description.
    portal_description: ?[]const u8 = null,

    /// The ID of the portal.
    portal_id: []const u8,

    /// The date the portal was last updated, in Unix epoch time.
    portal_last_update_date: i64,

    /// The portal's logo image, which is available at a URL.
    portal_logo_image_location: ?ImageLocation = null,

    /// The name of the portal.
    portal_name: []const u8,

    /// The URL for the IoT SiteWise Monitor portal. You can use this URL to access
    /// portals that
    /// use IAM Identity Center for authentication. For portals that use IAM for
    /// authentication, you must use the
    /// IoT SiteWise console to get a URL that you can use to access the portal.
    portal_start_url: []const u8,

    /// The current status of the portal, which contains a state and any error
    /// message.
    portal_status: ?PortalStatus = null,

    /// Define the type of portal. The value for IoT SiteWise Monitor (Classic) is
    /// `SITEWISE_PORTAL_V1`. The value for IoT SiteWise Monitor (AI-aware) is
    /// `SITEWISE_PORTAL_V2`.
    portal_type: ?PortalType = null,

    /// The configuration entry associated with the specific portal type. The value
    /// for IoT SiteWise Monitor (Classic) is `SITEWISE_PORTAL_V1`. The value for
    /// IoT SiteWise Monitor (AI-aware) is `SITEWISE_PORTAL_V2`.
    portal_type_configuration: ?[]const aws.map.MapEntry(PortalTypeEntry) = null,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the service role that allows the portal's users to access your IoT SiteWise
    /// resources on your behalf. For more information, see [Using service roles for
    /// IoT SiteWise
    /// Monitor](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/monitor-service-role.html) in the
    /// *IoT SiteWise User Guide*.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .alarms = "alarms",
        .notification_sender_email = "notificationSenderEmail",
        .portal_arn = "portalArn",
        .portal_auth_mode = "portalAuthMode",
        .portal_client_id = "portalClientId",
        .portal_contact_email = "portalContactEmail",
        .portal_creation_date = "portalCreationDate",
        .portal_description = "portalDescription",
        .portal_id = "portalId",
        .portal_last_update_date = "portalLastUpdateDate",
        .portal_logo_image_location = "portalLogoImageLocation",
        .portal_name = "portalName",
        .portal_start_url = "portalStartUrl",
        .portal_status = "portalStatus",
        .portal_type = "portalType",
        .portal_type_configuration = "portalTypeConfiguration",
        .role_arn = "roleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePortalInput, options: CallOptions) !DescribePortalOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotsitewise");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePortalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/portals/");
    try path_buf.appendSlice(allocator, input.portal_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePortalOutput {
    var result: DescribePortalOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribePortalOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConflictingOperationException")) {
        return .{ .arena = arena, .kind = .{ .conflicting_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
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
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .query_timeout_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
