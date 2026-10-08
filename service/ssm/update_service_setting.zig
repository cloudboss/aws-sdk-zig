const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateServiceSettingInput = struct {
    /// The Amazon Resource Name (ARN) of the service setting to update. For
    /// example,
    /// `arn:aws:ssm:us-east-1:111122223333:servicesetting/ssm/parameter-store/high-throughput-enabled`.
    /// The setting ID can be one of the following.
    ///
    /// * `/ssm/appmanager/appmanager-enabled`
    ///
    /// * `/ssm/automation/customer-script-log-destination`
    ///
    /// * `/ssm/automation/customer-script-log-group-name`
    ///
    /// * /ssm/automation/enable-adaptive-concurrency
    ///
    /// * `/ssm/documents/console/public-sharing-permission`
    ///
    /// * `/ssm/managed-instance/activation-tier`
    ///
    /// * `/ssm/managed-instance/default-ec2-instance-management-role`
    ///
    /// * `/ssm/opsinsights/opscenter`
    ///
    /// * `/ssm/parameter-store/default-parameter-tier`
    ///
    /// * `/ssm/parameter-store/high-throughput-enabled`
    ///
    /// Permissions to update the
    /// `/ssm/managed-instance/default-ec2-instance-management-role` setting should
    /// only be
    /// provided to administrators. Implement least privilege access when allowing
    /// individuals to
    /// configure or modify the Default Host Management Configuration.
    setting_id: []const u8,

    /// The new value to specify for the service setting. The following list
    /// specifies the available
    /// values for each setting.
    ///
    /// * For `/ssm/appmanager/appmanager-enabled`, enter `True` or
    /// `False`.
    ///
    /// * For `/ssm/automation/customer-script-log-destination`, enter `CloudWatch`.
    ///
    /// * For `/ssm/automation/customer-script-log-group-name`, enter the name of an
    /// Amazon CloudWatch Logs log group.
    ///
    /// * For `/ssm/documents/console/public-sharing-permission`, enter
    /// `Enable` or `Disable`.
    ///
    /// * For `/ssm/managed-instance/activation-tier`, enter `standard` or
    /// `advanced`.
    ///
    /// * For `/ssm/managed-instance/default-ec2-instance-management-role`, enter
    ///   the
    /// name of an IAM role.
    ///
    /// * For `/ssm/opsinsights/opscenter`, enter `Enabled` or
    /// `Disabled`.
    ///
    /// * For `/ssm/parameter-store/default-parameter-tier`, enter `Standard`,
    /// `Advanced`, or `Intelligent-Tiering`
    ///
    /// * For `/ssm/parameter-store/high-throughput-enabled`, enter `true` or
    /// `false`.
    setting_value: []const u8,

    pub const json_field_names = .{
        .setting_id = "SettingId",
        .setting_value = "SettingValue",
    };
};

pub const UpdateServiceSettingOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServiceSettingInput, options: CallOptions) !UpdateServiceSettingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateServiceSettingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.UpdateServiceSetting");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateServiceSettingOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
