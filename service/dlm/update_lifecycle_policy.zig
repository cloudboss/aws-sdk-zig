const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CrossRegionCopyTarget = @import("cross_region_copy_target.zig").CrossRegionCopyTarget;
const Exclusions = @import("exclusions.zig").Exclusions;
const PolicyDetails = @import("policy_details.zig").PolicyDetails;
const SettablePolicyStateValues = @import("settable_policy_state_values.zig").SettablePolicyStateValues;

pub const UpdateLifecyclePolicyInput = struct {
    /// **[Default policies only]** Indicates whether the policy should copy tags
    /// from the source resource
    /// to the snapshot or AMI.
    copy_tags: ?bool = null,

    /// **[Default policies only]** Specifies how often the policy should run and
    /// create snapshots or AMIs.
    /// The creation frequency can range from 1 to 7 days.
    create_interval: ?i32 = null,

    /// **[Default policies only]** Specifies destination Regions for snapshot or
    /// AMI copies. You can specify
    /// up to 3 destination Regions. If you do not want to create cross-Region
    /// copies, omit this
    /// parameter.
    cross_region_copy_targets: ?[]const CrossRegionCopyTarget = null,

    /// A description of the lifecycle policy.
    description: ?[]const u8 = null,

    /// **[Default policies only]** Specifies exclusion parameters for volumes or
    /// instances for which you
    /// do not want to create snapshots or AMIs. The policy will not create
    /// snapshots or AMIs
    /// for target resources that match any of the specified exclusion parameters.
    exclusions: ?Exclusions = null,

    /// The Amazon Resource Name (ARN) of the IAM role used to run the operations
    /// specified by
    /// the lifecycle policy.
    execution_role_arn: ?[]const u8 = null,

    /// **[Default policies only]** Defines the snapshot or AMI retention behavior
    /// for the policy if the
    /// source volume or instance is deleted, or if the policy enters the error,
    /// disabled, or
    /// deleted state.
    ///
    /// By default (**ExtendDeletion=false**):
    ///
    /// * If a source resource is deleted, Amazon Data Lifecycle Manager will
    ///   continue to delete previously
    /// created snapshots or AMIs, up to but not including the last one, based on
    /// the
    /// specified retention period. If you want Amazon Data Lifecycle Manager to
    /// delete all snapshots or AMIs,
    /// including the last one, specify `true`.
    ///
    /// * If a policy enters the error, disabled, or deleted state, Amazon Data
    ///   Lifecycle Manager stops deleting
    /// snapshots and AMIs. If you want Amazon Data Lifecycle Manager to continue
    /// deleting snapshots or AMIs,
    /// including the last one, if the policy enters one of these states, specify
    /// `true`.
    ///
    /// If you enable extended deletion (**ExtendDeletion=true**),
    /// you override both default behaviors simultaneously.
    ///
    /// Default: false
    extend_deletion: ?bool = null,

    /// The configuration of the lifecycle policy. You cannot update the policy type
    /// or the
    /// resource type.
    policy_details: ?PolicyDetails = null,

    /// The identifier of the lifecycle policy.
    policy_id: []const u8,

    /// **[Default policies only]** Specifies how long the policy should retain
    /// snapshots or AMIs before
    /// deleting them. The retention period can range from 2 to 14 days, but it must
    /// be greater
    /// than the creation frequency to ensure that the policy retains at least 1
    /// snapshot or
    /// AMI at any given time.
    retain_interval: ?i32 = null,

    /// The desired activation state of the lifecycle policy after creation.
    state: ?SettablePolicyStateValues = null,

    pub const json_field_names = .{
        .copy_tags = "CopyTags",
        .create_interval = "CreateInterval",
        .cross_region_copy_targets = "CrossRegionCopyTargets",
        .description = "Description",
        .exclusions = "Exclusions",
        .execution_role_arn = "ExecutionRoleArn",
        .extend_deletion = "ExtendDeletion",
        .policy_details = "PolicyDetails",
        .policy_id = "PolicyId",
        .retain_interval = "RetainInterval",
        .state = "State",
    };
};

pub const UpdateLifecyclePolicyOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLifecyclePolicyInput, options: CallOptions) !UpdateLifecyclePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "dlm");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLifecyclePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dlm", "DLM", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/policies/");
    try path_buf.appendSlice(allocator, input.policy_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.copy_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CopyTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.create_interval) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CreateInterval\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.cross_region_copy_targets) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CrossRegionCopyTargets\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.exclusions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Exclusions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExecutionRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.extend_deletion) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExtendDeletion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.policy_details) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PolicyDetails\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.retain_interval) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RetainInterval\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"State\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLifecyclePolicyOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateLifecyclePolicyOutput = .{};

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

    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
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
