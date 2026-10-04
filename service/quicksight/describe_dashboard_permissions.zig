const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LinkSharingConfiguration = @import("link_sharing_configuration.zig").LinkSharingConfiguration;
const ResourcePermission = @import("resource_permission.zig").ResourcePermission;

pub const DescribeDashboardPermissionsInput = struct {
    /// The ID of the Amazon Web Services account that contains the dashboard that
    /// you're
    /// describing permissions for.
    aws_account_id: []const u8,

    /// The ID for the dashboard, also added to the IAM policy.
    dashboard_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .dashboard_id = "DashboardId",
    };
};

pub const DescribeDashboardPermissionsOutput = struct {
    /// The Amazon Resource Name (ARN) of the dashboard.
    dashboard_arn: ?[]const u8 = null,

    /// The ID for the dashboard.
    dashboard_id: ?[]const u8 = null,

    /// A structure that contains the configuration of a shareable link that grants
    /// access to
    /// the dashboard. Your users can use the link to view and interact with the
    /// dashboard, if
    /// the dashboard has been shared with them. For more information about sharing
    /// dashboards,
    /// see [Sharing
    /// Dashboards](https://docs.aws.amazon.com/quicksight/latest/user/sharing-a-dashboard.html).
    link_sharing_configuration: ?LinkSharingConfiguration = null,

    /// A structure that contains the permissions for the dashboard.
    permissions: ?[]const ResourcePermission = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .dashboard_arn = "DashboardArn",
        .dashboard_id = "DashboardId",
        .link_sharing_configuration = "LinkSharingConfiguration",
        .permissions = "Permissions",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDashboardPermissionsInput, options: CallOptions) !DescribeDashboardPermissionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDashboardPermissionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/dashboards/");
    try path_buf.appendSlice(allocator, input.dashboard_id);
    try path_buf.appendSlice(allocator, "/permissions");
    const path = try path_buf.toOwnedSlice(allocator);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDashboardPermissionsOutput {
    var result: DescribeDashboardPermissionsOutput = try aws.json.parseJsonObject(
        DescribeDashboardPermissionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
