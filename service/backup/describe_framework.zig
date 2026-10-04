const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FrameworkControl = @import("framework_control.zig").FrameworkControl;

pub const DescribeFrameworkInput = struct {
    /// The unique name of a framework.
    framework_name: []const u8,

    pub const json_field_names = .{
        .framework_name = "FrameworkName",
    };
};

pub const DescribeFrameworkOutput = struct {
    /// The date and time that a framework is created, in ISO 8601 representation.
    /// The value of `CreationTime` is accurate to milliseconds. For example,
    /// 2020-07-10T15:00:00.000-08:00 represents the 10th of July 2020 at 3:00 PM 8
    /// hours behind
    /// UTC.
    creation_time: ?i64 = null,

    /// The deployment status of a framework. The statuses are:
    ///
    /// `CREATE_IN_PROGRESS | UPDATE_IN_PROGRESS | DELETE_IN_PROGRESS | COMPLETED |
    /// FAILED`
    deployment_status: ?[]const u8 = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
    /// format of the ARN
    /// depends on the resource type.
    framework_arn: ?[]const u8 = null,

    /// The controls that make up the framework. Each control in the list has a
    /// name,
    /// input parameters, and scope.
    framework_controls: ?[]const FrameworkControl = null,

    /// An optional description of the framework.
    framework_description: ?[]const u8 = null,

    /// The unique name of a framework.
    framework_name: ?[]const u8 = null,

    /// A framework consists of one or more controls. Each control governs a
    /// resource, such as
    /// backup plans, backup selections, backup vaults, or recovery points. You can
    /// also turn
    /// Config recording on or off for each resource. The statuses are:
    ///
    /// * `ACTIVE` when recording is turned on for all resources governed by the
    /// framework.
    ///
    /// * `PARTIALLY_ACTIVE` when recording is turned off for at least one
    /// resource governed by the framework.
    ///
    /// * `INACTIVE` when recording is turned off for all resources governed by
    /// the framework.
    ///
    /// * `UNAVAILABLE` when Backup is unable to validate recording
    /// status at this time.
    framework_status: ?[]const u8 = null,

    /// A customer-chosen string that you can use to distinguish between otherwise
    /// identical
    /// calls to `DescribeFrameworkOutput`. Retrying a successful request with the
    /// same
    /// idempotency token results in a success message with no action taken.
    idempotency_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .deployment_status = "DeploymentStatus",
        .framework_arn = "FrameworkArn",
        .framework_controls = "FrameworkControls",
        .framework_description = "FrameworkDescription",
        .framework_name = "FrameworkName",
        .framework_status = "FrameworkStatus",
        .idempotency_token = "IdempotencyToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFrameworkInput, options: CallOptions) !DescribeFrameworkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFrameworkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/audit/frameworks/");
    try path_buf.appendSlice(allocator, input.framework_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFrameworkOutput {
    const result: DescribeFrameworkOutput = try aws.json.parseJsonObject(
        DescribeFrameworkOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
