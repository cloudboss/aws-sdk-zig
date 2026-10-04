const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OptInLevel = @import("opt_in_level.zig").OptInLevel;
const OptInType = @import("opt_in_type.zig").OptInType;

pub const StartAutoManagementInput = struct {
    /// List of Amazon Web Services services excluded from Automatic Management.
    /// You won't be notified of Service Quotas utilization for Amazon Web Services
    /// services added to the
    /// Automatic Management exclusion list.
    exclusion_list: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The [User
    /// Notifications](https://docs.aws.amazon.com/notifications/latest/userguide/resource-level-permissions.html#rlp-table) Amazon Resource Name (ARN) for Automatic Management notifications.
    notification_arn: ?[]const u8 = null,

    /// Sets the opt-in level for Automatic Management. Only Amazon Web Services
    /// account level is supported.
    opt_in_level: OptInLevel,

    /// Sets the opt-in type for Automatic Management. There are two modes: Notify
    /// only and Notify and Auto-Adjust. Currently, only
    /// NotifyOnly is available.
    opt_in_type: OptInType,

    pub const json_field_names = .{
        .exclusion_list = "ExclusionList",
        .notification_arn = "NotificationArn",
        .opt_in_level = "OptInLevel",
        .opt_in_type = "OptInType",
    };
};

pub const StartAutoManagementOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAutoManagementInput, options: CallOptions) !StartAutoManagementOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAutoManagementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicequotas", "Service Quotas", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ServiceQuotasV20190624.StartAutoManagement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAutoManagementOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
