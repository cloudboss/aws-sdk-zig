const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ComputeResourceUpdate = @import("compute_resource_update.zig").ComputeResourceUpdate;
const CEState = @import("ce_state.zig").CEState;
const UpdatePolicy = @import("update_policy.zig").UpdatePolicy;

pub const UpdateComputeEnvironmentInput = struct {
    /// The name or full Amazon Resource Name (ARN) of the compute environment to
    /// update.
    compute_environment: []const u8,

    /// Details of the compute resources managed by the compute environment.
    /// Required for a
    /// managed compute environment. For more information, see [Compute
    /// Environments](https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html) in the
    /// *Batch User Guide*.
    compute_resources: ?ComputeResourceUpdate = null,

    /// Reserved.
    context: ?[]const u8 = null,

    /// The full Amazon Resource Name (ARN) of the IAM role that allows Batch to
    /// make calls to other Amazon Web Services
    /// services on your behalf. For more information, see [Batch service IAM
    /// role](https://docs.aws.amazon.com/batch/latest/userguide/service_IAM_role.html) in the
    /// *Batch User Guide*.
    ///
    /// If the compute environment has a service-linked role, it can't be changed to
    /// use a
    /// regular IAM role. Likewise, if the compute environment has a regular IAM
    /// role, it can't
    /// be changed to use a service-linked role. To update the parameters for the
    /// compute
    /// environment that require an infrastructure update to change, the
    /// **AWSServiceRoleForBatch** service-linked role must be used. For more
    /// information,
    /// see [Updating
    /// compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in the *Batch User Guide*.
    ///
    /// If your specified role has a path other than `/`, then you must either
    /// specify
    /// the full role ARN (recommended) or prefix the role name with the path.
    ///
    /// Depending on how you created your Batch service role, its ARN might contain
    /// the
    /// `service-role` path prefix. When you only specify the name of the service
    /// role,
    /// Batch assumes that your ARN doesn't use the `service-role` path prefix.
    /// Because
    /// of this, we recommend that you specify the full ARN of your service role
    /// when you create
    /// compute environments.
    service_role: ?[]const u8 = null,

    /// The state of the compute environment. Compute environments in the `ENABLED`
    /// state can accept jobs from a queue and scale in or out automatically based
    /// on the workload
    /// demand of its associated queues.
    ///
    /// If the state is `ENABLED`, then the Batch scheduler can attempt to place
    /// jobs
    /// from an associated job queue on the compute resources within the
    /// environment. If the compute
    /// environment is managed, then it can scale its instances out or in
    /// automatically, based on the
    /// job queue demand.
    ///
    /// If the state is `DISABLED`, then the Batch scheduler doesn't attempt to
    /// place
    /// jobs within the environment. Jobs in a `STARTING` or `RUNNING` state
    /// continue to progress normally. Managed compute environments in the
    /// `DISABLED` state
    /// don't scale out.
    ///
    /// Compute environments in a `DISABLED` state may continue to incur billing
    /// charges. To prevent additional charges, turn off and then delete the compute
    /// environment.
    /// For more information, see
    /// [State](https://docs.aws.amazon.com/batch/latest/userguide/compute_environment_parameters.html#compute_environment_state) in the *Batch User Guide*.
    ///
    /// When an instance is idle, the instance scales down to the `minvCpus` value.
    /// However, the instance size doesn't change. For example, consider a
    /// `c5.8xlarge`
    /// instance with a `minvCpus` value of `4` and a `desiredvCpus`
    /// value of `36`. This instance doesn't scale down to a `c5.large`
    /// instance.
    state: ?CEState = null,

    /// The maximum number of vCPUs expected to be used for an unmanaged compute
    /// environment.
    /// Don't specify this parameter for a managed compute environment. This
    /// parameter is only used
    /// for fair-share scheduling to reserve vCPU capacity for new share
    /// identifiers. If this
    /// parameter isn't provided for a fair-share job queue, no vCPU capacity is
    /// reserved.
    unmanagedv_cpus: ?i32 = null,

    /// Specifies the updated infrastructure update policy for the compute
    /// environment. For more
    /// information about infrastructure updates, see [Updating compute
    /// environments](https://docs.aws.amazon.com/batch/latest/userguide/updating-compute-environments.html) in
    /// the *Batch User Guide*.
    update_policy: ?UpdatePolicy = null,

    pub const json_field_names = .{
        .compute_environment = "computeEnvironment",
        .compute_resources = "computeResources",
        .context = "context",
        .service_role = "serviceRole",
        .state = "state",
        .unmanagedv_cpus = "unmanagedvCpus",
        .update_policy = "updatePolicy",
    };
};

pub const UpdateComputeEnvironmentOutput = struct {
    /// The Amazon Resource Name (ARN) of the compute environment.
    compute_environment_arn: ?[]const u8 = null,

    /// The name of the compute environment. It can be up to 128 characters long. It
    /// can contain uppercase and
    /// lowercase letters, numbers, hyphens (-), and underscores (_).
    compute_environment_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .compute_environment_arn = "computeEnvironmentArn",
        .compute_environment_name = "computeEnvironmentName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateComputeEnvironmentInput, options: CallOptions) !UpdateComputeEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "batch");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateComputeEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/updatecomputeenvironment";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"computeEnvironment\":");
    try aws.json.writeValue(@TypeOf(input.compute_environment), input.compute_environment, allocator, &body_buf);
    has_prev = true;
    if (input.compute_resources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"computeResources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.context) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"context\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.service_role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"serviceRole\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"state\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.unmanagedv_cpus) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"unmanagedvCpus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.update_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"updatePolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateComputeEnvironmentOutput {
    var result: UpdateComputeEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateComputeEnvironmentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ClientException")) {
        return .{ .arena = arena, .kind = .{ .client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
