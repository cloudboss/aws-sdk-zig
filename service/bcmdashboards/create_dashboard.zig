const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceTag = @import("resource_tag.zig").ResourceTag;
const Widget = @import("widget.zig").Widget;

pub const CreateDashboardInput = struct {
    /// A description of the dashboard's purpose or contents.
    description: ?[]const u8 = null,

    /// The name of the dashboard. The name must be unique within your account.
    name: []const u8,

    /// The tags to apply to the dashboard resource for organization and management.
    resource_tags: ?[]const ResourceTag = null,

    /// An array of widget configurations that define the visualizations to be
    /// displayed in the dashboard. Each dashboard can contain up to 20 widgets.
    widgets: []const Widget,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .resource_tags = "resourceTags",
        .widgets = "widgets",
    };
};

pub const CreateDashboardOutput = struct {
    /// The ARN of the newly created dashboard.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDashboardInput, options: CallOptions) !CreateDashboardOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDashboardInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSBCMDashboardsService.CreateDashboard");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDashboardOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateDashboardOutput, body, allocator);
}
