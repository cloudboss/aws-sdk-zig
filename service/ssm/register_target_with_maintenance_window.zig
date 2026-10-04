const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MaintenanceWindowResourceType = @import("maintenance_window_resource_type.zig").MaintenanceWindowResourceType;
const Target = @import("target.zig").Target;

pub const RegisterTargetWithMaintenanceWindowInput = struct {
    /// User-provided idempotency token.
    client_token: ?[]const u8 = null,

    /// An optional description for the target.
    description: ?[]const u8 = null,

    /// An optional name for the target.
    name: ?[]const u8 = null,

    /// User-provided value that will be included in any Amazon CloudWatch Events
    /// events raised while
    /// running tasks for these targets in this maintenance window.
    owner_information: ?[]const u8 = null,

    /// The type of target being registered with the maintenance window.
    resource_type: MaintenanceWindowResourceType,

    /// The targets to register with the maintenance window. In other words, the
    /// managed nodes to
    /// run commands on when the maintenance window runs.
    ///
    /// If a single maintenance window task is registered with multiple targets, its
    /// task
    /// invocations occur sequentially and not in parallel. If your task must run on
    /// multiple targets at
    /// the same time, register a task for each target individually and assign each
    /// task the same
    /// priority level.
    ///
    /// You can specify targets using managed node IDs, resource group names, or
    /// tags that have been
    /// applied to managed nodes.
    ///
    /// **Example 1**: Specify managed node IDs
    ///
    /// `Key=InstanceIds,Values=,,`
    ///
    /// **Example 2**: Use tag key-pairs applied to managed
    /// nodes
    ///
    /// `Key=tag:,Values=,`
    ///
    /// **Example 3**: Use tag-keys applied to managed nodes
    ///
    /// `Key=tag-key,Values=,`
    ///
    /// **Example 4**: Use resource group names
    ///
    /// `Key=resource-groups:Name,Values=`
    ///
    /// **Example 5**: Use filters for resource group types
    ///
    /// `Key=resource-groups:ResourceTypeFilters,Values=,`
    ///
    /// For `Key=resource-groups:ResourceTypeFilters`, specify resource types in the
    /// following format
    ///
    /// `Key=resource-groups:ResourceTypeFilters,Values=AWS::EC2::INSTANCE,AWS::EC2::VPC`
    ///
    /// For more information about these examples formats, including the best use
    /// case for each one,
    /// see [Examples: Register
    /// targets with a maintenance
    /// window](https://docs.aws.amazon.com/systems-manager/latest/userguide/mw-cli-tutorial-targets-examples.html) in the *Amazon Web Services Systems Manager User Guide*.
    targets: []const Target,

    /// The ID of the maintenance window the target should be registered with.
    window_id: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .name = "Name",
        .owner_information = "OwnerInformation",
        .resource_type = "ResourceType",
        .targets = "Targets",
        .window_id = "WindowId",
    };
};

pub const RegisterTargetWithMaintenanceWindowOutput = struct {
    /// The ID of the target definition in this maintenance window.
    window_target_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .window_target_id = "WindowTargetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterTargetWithMaintenanceWindowInput, options: CallOptions) !RegisterTargetWithMaintenanceWindowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterTargetWithMaintenanceWindowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.RegisterTargetWithMaintenanceWindow");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterTargetWithMaintenanceWindowOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RegisterTargetWithMaintenanceWindowOutput, body, allocator);
}
