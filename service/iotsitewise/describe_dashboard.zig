const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeDashboardInput = struct {
    /// The ID of the dashboard.
    dashboard_id: []const u8,

    pub const json_field_names = .{
        .dashboard_id = "dashboardId",
    };
};

pub const DescribeDashboardOutput = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the dashboard, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:dashboard/${DashboardId}`
    dashboard_arn: []const u8,

    /// The date the dashboard was created, in Unix epoch time.
    dashboard_creation_date: i64,

    /// The dashboard's definition JSON literal. For detailed information, see
    /// [Creating
    /// dashboards
    /// (CLI)](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/create-dashboards-using-aws-cli.html) in the *IoT SiteWise User Guide*.
    dashboard_definition: []const u8,

    /// The dashboard's description.
    dashboard_description: ?[]const u8 = null,

    /// The ID of the dashboard.
    dashboard_id: []const u8,

    /// The date the dashboard was last updated, in Unix epoch time.
    dashboard_last_update_date: i64,

    /// The name of the dashboard.
    dashboard_name: []const u8,

    /// The ID of the project that the dashboard is in.
    project_id: []const u8,

    pub const json_field_names = .{
        .dashboard_arn = "dashboardArn",
        .dashboard_creation_date = "dashboardCreationDate",
        .dashboard_definition = "dashboardDefinition",
        .dashboard_description = "dashboardDescription",
        .dashboard_id = "dashboardId",
        .dashboard_last_update_date = "dashboardLastUpdateDate",
        .dashboard_name = "dashboardName",
        .project_id = "projectId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDashboardInput, options: CallOptions) !DescribeDashboardOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDashboardInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/dashboards/");
    try path_buf.appendSlice(allocator, input.dashboard_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDashboardOutput {
    var result: DescribeDashboardOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDashboardOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
