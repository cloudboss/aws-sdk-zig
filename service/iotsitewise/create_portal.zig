const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Alarms = @import("alarms.zig").Alarms;
const AuthMode = @import("auth_mode.zig").AuthMode;
const ImageFile = @import("image_file.zig").ImageFile;
const PortalType = @import("portal_type.zig").PortalType;
const PortalTypeEntry = @import("portal_type_entry.zig").PortalTypeEntry;
const PortalStatus = @import("portal_status.zig").PortalStatus;

pub const CreatePortalInput = struct {
    /// Contains the configuration information of an alarm created in an IoT
    /// SiteWise Monitor portal.
    /// You can use the alarm to monitor an asset property and get notified when the
    /// asset property value is outside a specified range.
    /// For more information, see [Monitoring with
    /// alarms](https://docs.aws.amazon.com/iot-sitewise/latest/appguide/monitor-alarms.html) in the *IoT SiteWise Application Guide*.
    alarms: ?Alarms = null,

    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request. Don't reuse this client token if a new
    /// idempotent request is required.
    client_token: ?[]const u8 = null,

    /// The email address that sends alarm notifications.
    ///
    /// If you use the [IoT Events managed Lambda
    /// function](https://docs.aws.amazon.com/iotevents/latest/developerguide/lambda-support.html) to manage your emails, you must [verify the sender email
    /// address in Amazon
    /// SES](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/verify-email-addresses.html).
    notification_sender_email: ?[]const u8 = null,

    /// The service to use to authenticate users to the portal. Choose from the
    /// following
    /// options:
    ///
    /// * `SSO` – The portal uses IAM Identity Center to authenticate users and
    ///   manage
    /// user permissions. Before you can create a portal that uses IAM Identity
    /// Center, you must enable IAM Identity Center.
    /// For more information, see [Enabling IAM Identity
    /// Center](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/monitor-get-started.html#mon-gs-sso) in the
    /// *IoT SiteWise User Guide*. This option is only available in Amazon Web
    /// Services Regions other than
    /// the China Regions.
    ///
    /// * `IAM` – The portal uses Identity and Access Management to authenticate
    ///   users and manage
    /// user permissions.
    ///
    /// You can't change this value after you create a portal.
    ///
    /// Default: `SSO`
    portal_auth_mode: ?AuthMode = null,

    /// The Amazon Web Services administrator's contact email address.
    portal_contact_email: []const u8,

    /// A description for the portal.
    portal_description: ?[]const u8 = null,

    /// A logo image to display in the portal. Upload a square, high-resolution
    /// image. The
    /// image is displayed on a dark background.
    portal_logo_image_file: ?ImageFile = null,

    /// A friendly name for the portal.
    portal_name: []const u8,

    /// Define the type of portal. The value for IoT SiteWise Monitor (Classic) is
    /// `SITEWISE_PORTAL_V1`. The value for IoT SiteWise Monitor (AI-aware) is
    /// `SITEWISE_PORTAL_V2`.
    portal_type: ?PortalType = null,

    /// The configuration entry associated with the specific portal type. The value
    /// for IoT SiteWise Monitor (Classic) is `SITEWISE_PORTAL_V1`. The value for
    /// IoT SiteWise Monitor (AI-aware) is `SITEWISE_PORTAL_V2`.
    portal_type_configuration: ?[]const aws.map.MapEntry(PortalTypeEntry) = null,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of a service role that allows the portal's users to access your IoT SiteWise
    /// resources on your behalf. For more information, see [Using service roles for
    /// IoT SiteWise
    /// Monitor](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/monitor-service-role.html) in the
    /// *IoT SiteWise User Guide*.
    role_arn: []const u8,

    /// A list of key-value pairs that contain metadata for the portal. For more
    /// information, see
    /// [Tagging your IoT SiteWise
    /// resources](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/tag-resources.html) in the *IoT SiteWise User Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .alarms = "alarms",
        .client_token = "clientToken",
        .notification_sender_email = "notificationSenderEmail",
        .portal_auth_mode = "portalAuthMode",
        .portal_contact_email = "portalContactEmail",
        .portal_description = "portalDescription",
        .portal_logo_image_file = "portalLogoImageFile",
        .portal_name = "portalName",
        .portal_type = "portalType",
        .portal_type_configuration = "portalTypeConfiguration",
        .role_arn = "roleArn",
        .tags = "tags",
    };
};

pub const CreatePortalOutput = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the portal, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:portal/${PortalId}`
    portal_arn: []const u8,

    /// The ID of the created portal.
    portal_id: []const u8,

    /// The URL for the IoT SiteWise Monitor portal. You can use this URL to access
    /// portals that
    /// use IAM Identity Center for authentication. For portals that use IAM for
    /// authentication, you must use the
    /// IoT SiteWise console to get a URL that you can use to access the portal.
    portal_start_url: []const u8,

    /// The status of the portal, which contains a state (`CREATING` after
    /// successfully
    /// calling this operation) and any error message.
    portal_status: ?PortalStatus = null,

    /// The associated IAM Identity Center application ID, if the portal uses IAM
    /// Identity Center.
    sso_application_id: []const u8,

    pub const json_field_names = .{
        .portal_arn = "portalArn",
        .portal_id = "portalId",
        .portal_start_url = "portalStartUrl",
        .portal_status = "portalStatus",
        .sso_application_id = "ssoApplicationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePortalInput, options: CallOptions) !CreatePortalOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePortalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/portals";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.alarms) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"alarms\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.notification_sender_email) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"notificationSenderEmail\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.portal_auth_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"portalAuthMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"portalContactEmail\":");
    try aws.json.writeValue(@TypeOf(input.portal_contact_email), input.portal_contact_email, allocator, &body_buf);
    has_prev = true;
    if (input.portal_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"portalDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.portal_logo_image_file) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"portalLogoImageFile\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"portalName\":");
    try aws.json.writeValue(@TypeOf(input.portal_name), input.portal_name, allocator, &body_buf);
    has_prev = true;
    if (input.portal_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"portalType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.portal_type_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"portalTypeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePortalOutput {
    const result: CreatePortalOutput = try aws.json.parseJsonObject(
        CreatePortalOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
