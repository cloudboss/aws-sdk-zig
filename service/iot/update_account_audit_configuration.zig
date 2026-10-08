const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditCheckConfiguration = @import("audit_check_configuration.zig").AuditCheckConfiguration;
const AuditNotificationTarget = @import("audit_notification_target.zig").AuditNotificationTarget;

pub const UpdateAccountAuditConfigurationInput = struct {
    /// Specifies which audit checks are enabled and disabled for this account. Use
    /// `DescribeAccountAuditConfiguration` to see the list of all checks, including
    /// those
    /// that are currently enabled.
    ///
    /// Some data collection might start immediately when certain checks are
    /// enabled.
    /// When a check is disabled, any data collected so far in relation to the check
    /// is deleted.
    ///
    /// You
    /// cannot
    /// disable a check if
    /// it's
    /// used by any scheduled audit. You must first delete the check from the
    /// scheduled audit or
    /// delete the scheduled audit itself.
    ///
    /// On the first call to `UpdateAccountAuditConfiguration`,
    /// this parameter is required and must specify at least one enabled check.
    audit_check_configurations: ?[]const aws.map.MapEntry(AuditCheckConfiguration) = null,

    /// Information about the targets to which audit notifications are sent.
    audit_notification_target_configurations: ?[]const aws.map.MapEntry(AuditNotificationTarget) = null,

    /// The Amazon
    /// Resource Name
    /// (ARN)
    /// of the role that grants permission
    /// to
    /// IoT to access information about your devices, policies,
    /// certificates,
    /// and other items as required when performing an audit.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .audit_check_configurations = "auditCheckConfigurations",
        .audit_notification_target_configurations = "auditNotificationTargetConfigurations",
        .role_arn = "roleArn",
    };
};

pub const UpdateAccountAuditConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccountAuditConfigurationInput, options: CallOptions) !UpdateAccountAuditConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccountAuditConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/audit/configuration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.audit_check_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"auditCheckConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.audit_notification_target_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"auditNotificationTargetConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccountAuditConfigurationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateAccountAuditConfigurationOutput = .{};

    return result;
}
