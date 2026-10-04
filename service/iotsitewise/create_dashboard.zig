const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateDashboardInput = struct {
    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request. Don't reuse this client token if a new
    /// idempotent request is required.
    client_token: ?[]const u8 = null,

    /// The dashboard definition specified in a JSON literal.
    ///
    /// * IoT SiteWise Monitor (Classic) see [Create dashboards
    ///   (CLI)](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/create-dashboards-using-aws-cli.html)
    ///
    /// * IoT SiteWise Monitor (AI-aware) see [Create dashboards
    ///   (CLI)](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/create-dashboards-ai-dashboard-cli.html)
    ///
    /// in the *IoT SiteWise User Guide*
    dashboard_definition: []const u8,

    /// A description for the dashboard.
    dashboard_description: ?[]const u8 = null,

    /// A friendly name for the dashboard.
    dashboard_name: []const u8,

    /// The ID of the project in which to create the dashboard.
    project_id: []const u8,

    /// A list of key-value pairs that contain metadata for the dashboard. For more
    /// information,
    /// see [Tagging your IoT SiteWise
    /// resources](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/tag-resources.html) in the *IoT SiteWise User Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .dashboard_definition = "dashboardDefinition",
        .dashboard_description = "dashboardDescription",
        .dashboard_name = "dashboardName",
        .project_id = "projectId",
        .tags = "tags",
    };
};

pub const CreateDashboardOutput = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the dashboard, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:dashboard/${DashboardId}`
    dashboard_arn: []const u8,

    /// The ID of the dashboard.
    dashboard_id: []const u8,

    pub const json_field_names = .{
        .dashboard_arn = "dashboardArn",
        .dashboard_id = "dashboardId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDashboardInput, options: CallOptions) !CreateDashboardOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDashboardInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/dashboards";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dashboardDefinition\":");
    try aws.json.writeValue(@TypeOf(input.dashboard_definition), input.dashboard_definition, allocator, &body_buf);
    has_prev = true;
    if (input.dashboard_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dashboardDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dashboardName\":");
    try aws.json.writeValue(@TypeOf(input.dashboard_name), input.dashboard_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"projectId\":");
    try aws.json.writeValue(@TypeOf(input.project_id), input.project_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDashboardOutput {
    const result: CreateDashboardOutput = try aws.json.parseJsonObject(
        CreateDashboardOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
