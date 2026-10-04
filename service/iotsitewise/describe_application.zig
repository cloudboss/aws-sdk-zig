const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApplicationStatus = @import("application_status.zig").ApplicationStatus;

pub const DescribeApplicationInput = struct {
    /// ID of the Application
    id: []const u8,

    /// Name of the workspace to associate with the underlying Application
    workspace_name: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .workspace_name = "workspaceName",
    };
};

pub const DescribeApplicationOutput = struct {
    /// ARN of the application
    arn: []const u8,

    /// Timestamp when the application was created
    created_at: i64,

    /// Description of the application
    description: ?[]const u8 = null,

    /// DNS subdomain for the application
    dns_subdomain: []const u8,

    /// Unique identifier of the application
    id: []const u8,

    /// Identity Center Application ARN associated with this application
    idc_application_arn: []const u8,

    /// Name of the application
    name: []const u8,

    /// Current status of the application
    status: ApplicationStatus,

    /// Timestamp when the application was last updated
    updated_at: i64,

    /// Name of the workspace this application belongs to
    workspace_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .dns_subdomain = "dnsSubdomain",
        .id = "id",
        .idc_application_arn = "idcApplicationArn",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
        .workspace_name = "workspaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeApplicationInput, options: CallOptions) !DescribeApplicationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeApplicationOutput {
    const result: DescribeApplicationOutput = try aws.json.parseJsonObject(
        DescribeApplicationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
