const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeployedVersionSummary = @import("deployed_version_summary.zig").DeployedVersionSummary;
const EngineType = @import("engine_type.zig").EngineType;
const ApplicationVersionSummary = @import("application_version_summary.zig").ApplicationVersionSummary;
const LogGroupSummary = @import("log_group_summary.zig").LogGroupSummary;
const ApplicationLifecycle = @import("application_lifecycle.zig").ApplicationLifecycle;

pub const GetApplicationInput = struct {
    /// The identifier of the application.
    application_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
    };
};

pub const GetApplicationOutput = struct {
    /// The Amazon Resource Name (ARN) of the application.
    application_arn: []const u8,

    /// The identifier of the application.
    application_id: []const u8,

    /// The timestamp when this application was created.
    creation_time: i64,

    /// The version of the application that is deployed.
    deployed_version: ?DeployedVersionSummary = null,

    /// The description of the application.
    description: ?[]const u8 = null,

    /// The type of the target platform for the application.
    engine_type: EngineType,

    /// The identifier of the runtime environment where you want to deploy the
    /// application.
    environment_id: ?[]const u8 = null,

    /// The identifier of a customer managed key.
    kms_key_id: ?[]const u8 = null,

    /// The timestamp when you last started the application. Null until the
    /// application runs for
    /// the first time.
    last_start_time: ?i64 = null,

    /// The latest version of the application.
    latest_version: ?ApplicationVersionSummary = null,

    /// The Amazon Resource Name (ARN) for the network load balancer listener
    /// created in your
    /// Amazon Web Services account. Amazon Web Services Mainframe Modernization
    /// creates this listener for you the first time you deploy an
    /// application.
    listener_arns: ?[]const []const u8 = null,

    /// The port associated with the network load balancer listener created in your
    /// Amazon Web Services
    /// account.
    listener_ports: ?[]const i32 = null,

    /// The public DNS name of the load balancer created in your Amazon Web Services
    /// account.
    load_balancer_dns_name: ?[]const u8 = null,

    /// The list of log summaries. Each log summary includes the log type as well as
    /// the log
    /// group identifier. These are CloudWatch logs. Amazon Web Services Mainframe
    /// Modernization pushes the application log to CloudWatch under
    /// the customer's account.
    log_groups: ?[]const LogGroupSummary = null,

    /// The unique identifier of the application.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the role associated with the application.
    role_arn: ?[]const u8 = null,

    /// The status of the application.
    status: ApplicationLifecycle,

    /// The reason for the reported status.
    status_reason: ?[]const u8 = null,

    /// A list of tags associated with the application.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Returns the Amazon Resource Names (ARNs) of the target groups that are
    /// attached to the
    /// network load balancer.
    target_group_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
        .application_id = "applicationId",
        .creation_time = "creationTime",
        .deployed_version = "deployedVersion",
        .description = "description",
        .engine_type = "engineType",
        .environment_id = "environmentId",
        .kms_key_id = "kmsKeyId",
        .last_start_time = "lastStartTime",
        .latest_version = "latestVersion",
        .listener_arns = "listenerArns",
        .listener_ports = "listenerPorts",
        .load_balancer_dns_name = "loadBalancerDnsName",
        .log_groups = "logGroups",
        .name = "name",
        .role_arn = "roleArn",
        .status = "status",
        .status_reason = "statusReason",
        .tags = "tags",
        .target_group_arns = "targetGroupArns",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApplicationInput, options: CallOptions) !GetApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "m2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("m2", "m2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApplicationOutput {
    var result: GetApplicationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetApplicationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
