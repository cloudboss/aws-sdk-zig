const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QuotaInfo = @import("quota_info.zig").QuotaInfo;
const OptInLevel = @import("opt_in_level.zig").OptInLevel;
const OptInStatus = @import("opt_in_status.zig").OptInStatus;
const OptInType = @import("opt_in_type.zig").OptInType;

pub const GetAutoManagementConfigurationInput = struct {};

pub const GetAutoManagementConfigurationOutput = struct {
    /// List of Amazon Web Services services excluded from Automatic Management.
    /// You won't be notified of Service Quotas utilization for Amazon Web Services
    /// services added to the
    /// Automatic Management exclusion list.
    exclusion_list: ?[]const aws.map.MapEntry([]const QuotaInfo) = null,

    /// The [User
    /// Notifications](https://docs.aws.amazon.com/notifications/latest/userguide/resource-level-permissions.html#rlp-table) Amazon Resource Name (ARN) for Automatic Management notifications.
    notification_arn: ?[]const u8 = null,

    /// Information on the opt-in level for Automatic Management. Only Amazon Web
    /// Services account level is supported.
    opt_in_level: ?OptInLevel = null,

    /// Status on whether Automatic Management is started or stopped.
    opt_in_status: ?OptInStatus = null,

    /// Information on the opt-in type for Automatic Management. There are two
    /// modes: Notify only and Notify and Auto-Adjust. Currently, only
    /// NotifyOnly is available.
    opt_in_type: ?OptInType = null,

    pub const json_field_names = .{
        .exclusion_list = "ExclusionList",
        .notification_arn = "NotificationArn",
        .opt_in_level = "OptInLevel",
        .opt_in_status = "OptInStatus",
        .opt_in_type = "OptInType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAutoManagementConfigurationInput, options: CallOptions) !GetAutoManagementConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicequotas", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAutoManagementConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("servicequotas", "Service Quotas", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ServiceQuotasV20190624.GetAutoManagementConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAutoManagementConfigurationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAutoManagementConfigurationOutput, body, allocator);
}
