const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DashboardType = @import("dashboard_type.zig").DashboardType;
const Widget = @import("widget.zig").Widget;

pub const GetDashboardInput = struct {
    /// The ARN of the dashboard to retrieve. This is required to uniquely identify
    /// the dashboard.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub const GetDashboardOutput = struct {
    /// The ARN of the retrieved dashboard.
    arn: []const u8,

    /// The timestamp when the dashboard was created.
    created_at: i64,

    /// The description of the retrieved dashboard.
    description: ?[]const u8 = null,

    /// The name of the retrieved dashboard.
    name: []const u8,

    /// Indicates the dashboard type.
    @"type": DashboardType,

    /// The timestamp when the dashboard was last modified.
    updated_at: i64,

    /// An array of widget configurations that make up the dashboard.
    widgets: ?[]const Widget = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .@"type" = "type",
        .updated_at = "updatedAt",
        .widgets = "widgets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDashboardInput, options: CallOptions) !GetDashboardOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bcm-dashboards", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDashboardInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bcm-dashboards", "BCM Dashboards", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMDashboardsService.GetDashboard");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDashboardOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetDashboardOutput, body, allocator);
}
