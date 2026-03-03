const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ComputeResource = @import("compute_resource.zig").ComputeResource;
const EksConfiguration = @import("eks_configuration.zig").EksConfiguration;
const CEState = @import("ce_state.zig").CEState;
const CEType = @import("ce_type.zig").CEType;

pub const CreateComputeEnvironmentInput = struct {
    /// The name for your compute environment. It can be up to 128 characters long.
    /// It can contain uppercase and
    /// lowercase letters, numbers, hyphens (-), and underscores (_).
    compute_environment_name: []const u8,

    /// Details about the compute resources managed by the compute environment. This
    /// parameter is
    /// required for managed compute environments. For more information, see
    /// [Compute
    /// Environments](https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html)
    /// in the *Batch User Guide*.
    compute_resources: ?ComputeResource = null,

    /// Reserved.
    context: ?[]const u8 = null,

    /// The details for the Amazon EKS cluster that supports the compute
    /// environment.
    ///
    /// To create a compute environment that uses EKS resources, the caller must
    /// have
    /// permissions to call `eks:DescribeCluster`.
    eks_configuration: ?EksConfiguration = null,

    /// The full Amazon Resource Name (ARN) of the IAM role that allows Batch to
    /// make calls to other Amazon Web Services
    /// services on your behalf. For more information, see [Batch service IAM
    /// role](https://docs.aws.amazon.com/batch/latest/userguide/service_IAM_role.html) in the
    /// *Batch User Guide*.
    ///
    /// If your account already created the Batch service-linked role, that role is
    /// used by
    /// default for your compute environment unless you specify a different role
    /// here. If the
    /// Batch service-linked role doesn't exist in your account, and no role is
    /// specified here,
    /// the service attempts to create the Batch service-linked role in your
    /// account.
    ///
    /// If your specified role has a path other than `/`, then you must specify
    /// either
    /// the full role ARN (recommended) or prefix the role name with the path. For
    /// example, if a
    /// role with the name `bar` has a path of `/foo/`, specify
    /// `/foo/bar` as the role name. For more information, see [Friendly
    /// names and
    /// paths](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-friendly-names) in the *IAM User Guide*.
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

    /// The state of the compute environment. If the state is `ENABLED`, then the
    /// compute environment accepts jobs from a queue and can scale out
    /// automatically based on
    /// queues.
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

    /// The tags that you apply to the compute environment to help you categorize
    /// and organize
    /// your resources. Each tag consists of a key and an optional value. For more
    /// information, see
    /// [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in *Amazon Web Services General Reference*.
    ///
    /// These tags can be updated or removed using the
    /// [TagResource](https://docs.aws.amazon.com/batch/latest/APIReference/API_TagResource.html) and [UntagResource](https://docs.aws.amazon.com/batch/latest/APIReference/API_UntagResource.html) API operations. These tags don't propagate to the underlying compute
    /// resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the compute environment: `MANAGED` or `UNMANAGED`. For
    /// more information, see [Compute
    /// Environments](https://docs.aws.amazon.com/batch/latest/userguide/compute_environments.html) in the *Batch User Guide*.
    @"type": CEType,

    /// The maximum number of vCPUs for an unmanaged compute environment. This
    /// parameter is only
    /// used for fair-share scheduling to reserve vCPU capacity for new share
    /// identifiers. If this
    /// parameter isn't provided for a fair-share job queue, no vCPU capacity is
    /// reserved.
    ///
    /// This parameter is only supported when the `type` parameter is set to
    /// `UNMANAGED`.
    unmanagedv_cpus: ?i32 = null,

    pub const json_field_names = .{
        .compute_environment_name = "computeEnvironmentName",
        .compute_resources = "computeResources",
        .context = "context",
        .eks_configuration = "eksConfiguration",
        .service_role = "serviceRole",
        .state = "state",
        .tags = "tags",
        .@"type" = "type",
        .unmanagedv_cpus = "unmanagedvCpus",
    };
};

pub const CreateComputeEnvironmentOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateComputeEnvironmentInput, options: CallOptions) !CreateComputeEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateComputeEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/createcomputeenvironment";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"computeEnvironmentName\":");
    try aws.json.writeValue(@TypeOf(input.compute_environment_name), input.compute_environment_name, allocator, &body_buf);
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
    if (input.eks_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"eksConfiguration\":");
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
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;
    if (input.unmanagedv_cpus) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"unmanagedvCpus\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateComputeEnvironmentOutput {
    var result: CreateComputeEnvironmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateComputeEnvironmentOutput, body, allocator);
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
