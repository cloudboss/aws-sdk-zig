const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeProjectInput = struct {
    /// The ID of the project.
    project_id: []const u8,

    pub const json_field_names = .{
        .project_id = "projectId",
    };
};

pub const DescribeProjectOutput = struct {
    /// The ID of the portal that the project is in.
    portal_id: []const u8,

    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the project, which has the following format.
    ///
    /// `arn:${Partition}:iotsitewise:${Region}:${Account}:project/${ProjectId}`
    project_arn: []const u8,

    /// The date the project was created, in Unix epoch time.
    project_creation_date: i64,

    /// The project's description.
    project_description: ?[]const u8 = null,

    /// The ID of the project.
    project_id: []const u8,

    /// The date the project was last updated, in Unix epoch time.
    project_last_update_date: i64,

    /// The name of the project.
    project_name: []const u8,

    pub const json_field_names = .{
        .portal_id = "portalId",
        .project_arn = "projectArn",
        .project_creation_date = "projectCreationDate",
        .project_description = "projectDescription",
        .project_id = "projectId",
        .project_last_update_date = "projectLastUpdateDate",
        .project_name = "projectName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProjectInput, options: CallOptions) !DescribeProjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/projects/");
    try path_buf.appendSlice(allocator, input.project_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProjectOutput {
    const result: DescribeProjectOutput = try aws.json.parseJsonObject(
        DescribeProjectOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
