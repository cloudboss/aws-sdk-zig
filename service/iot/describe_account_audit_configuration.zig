const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuditCheckConfiguration = @import("audit_check_configuration.zig").AuditCheckConfiguration;
const AuditNotificationTarget = @import("audit_notification_target.zig").AuditNotificationTarget;

pub const DescribeAccountAuditConfigurationInput = struct {
};

pub const DescribeAccountAuditConfigurationOutput = struct {
    /// Which audit checks are enabled and disabled for this account.
    audit_check_configurations: ?[]const aws.map.MapEntry(AuditCheckConfiguration) = null,

    /// Information about the targets to which audit notifications are sent for
    /// this account.
    audit_notification_target_configurations: ?[]const aws.map.MapEntry(AuditNotificationTarget) = null,

    /// The ARN of the role that grants permission to IoT to access information
    /// about your devices, policies, certificates, and other items as required when
    /// performing an audit.
    ///
    /// On the first call to `UpdateAccountAuditConfiguration`,
    /// this parameter is required.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .audit_check_configurations = "auditCheckConfigurations",
        .audit_notification_target_configurations = "auditNotificationTargetConfigurations",
        .role_arn = "roleArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAccountAuditConfigurationInput, options: CallOptions) !DescribeAccountAuditConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAccountAuditConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/audit/configuration";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAccountAuditConfigurationOutput {
    const result: DescribeAccountAuditConfigurationOutput = try aws.json.parseJsonObject(
        DescribeAccountAuditConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
