const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceStateUpdateExclusionRules = @import("resource_state_update_exclusion_rules.zig").ResourceStateUpdateExclusionRules;
const ResourceStateUpdateIncludeResources = @import("resource_state_update_include_resources.zig").ResourceStateUpdateIncludeResources;
const ResourceState = @import("resource_state.zig").ResourceState;

pub const StartResourceStateUpdateInput = struct {
    /// A unique, case-sensitive identifier you provide to ensure
    /// that the operation runs no more than one time. If you retry a request with
    /// the same client
    /// token, Image Builder returns the original response without running the
    /// operation again. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html)
    /// in the *Amazon EC2 API Reference*.
    client_token: []const u8,

    /// Rules that Image Builder evaluates against each of the image's AMIs.
    /// Matching
    /// AMIs and their snapshots are skipped. Exclusion rules only take effect when
    /// the request includes AMIs. If the target state is `DELETED` and
    /// any resource was skipped, the Image Builder image resource itself is also
    /// retained.
    /// For the `DEPRECATED` and `DISABLED` target states,
    /// Image Builder updates the image resource's state regardless of
    /// exclusions.
    exclusion_rules: ?ResourceStateUpdateExclusionRules = null,

    /// The name or Amazon Resource Name (ARN) of the IAM role that's used to update
    /// image state. You
    /// must provide this property together with `includeResources`.
    /// Neither is valid without the other.
    execution_role: ?[]const u8 = null,

    /// Specifies which underlying resources to update, in addition to the Image
    /// Builder
    /// image resource itself. Snapshots and containers are only valid for the
    /// `DELETED` state. To set an image to `DELETED`, you
    /// must include its underlying resources. To delete only the Image Builder
    /// image
    /// record, use the DeleteImage operation instead.
    include_resources: ?ResourceStateUpdateIncludeResources = null,

    /// The Amazon Resource Name (ARN) of the image build version to update. The
    /// image must be in one of these terminal states: `AVAILABLE`,
    /// `DEPRECATED`, `DISABLED`,
    /// `FAILED`, or `CANCELLED`. Images with
    /// `FAILED` or `CANCELLED` status can transition only
    /// to `DELETED`.
    resource_arn: []const u8,

    /// Specifies the lifecycle action to take for this request. For AMI-based
    /// images, valid values are `AVAILABLE`,
    /// `DEPRECATED`, `DISABLED`, and
    /// `DELETED`. For container-based images, only
    /// `DELETED` is supported.
    state: ResourceState,

    /// The timestamp that indicates when resources are updated by a lifecycle
    /// action. This property is valid only when the target status is
    /// `DEPRECATED`, and the value must be a future time. If you
    /// don't specify a value, Image Builder begins the state update right away. For
    /// a
    /// scheduled deprecation, included AMIs get their EC2 deprecation time set
    /// immediately, and Image Builder schedules the image resource to transition to
    /// `DEPRECATED` at that time.
    update_at: ?i64 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .exclusion_rules = "exclusionRules",
        .execution_role = "executionRole",
        .include_resources = "includeResources",
        .resource_arn = "resourceArn",
        .state = "state",
        .update_at = "updateAt",
    };
};

pub const StartResourceStateUpdateOutput = struct {
    /// Identifies the lifecycle execution that performs the resource state update.
    /// Image Builder only returns this field when it started a lifecycle execution
    /// for the
    /// update. Use it with GetLifecycleExecution to track
    /// progress.
    lifecycle_execution_id: ?[]const u8 = null,

    /// The requested Amazon Resource Name (ARN) of the Image Builder resource for
    /// the asynchronous update.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .lifecycle_execution_id = "lifecycleExecutionId",
        .resource_arn = "resourceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartResourceStateUpdateInput, options: CallOptions) !StartResourceStateUpdateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "imagebuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartResourceStateUpdateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/StartResourceStateUpdate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.exclusion_rules) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"exclusionRules\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.execution_role) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"executionRole\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.include_resources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"includeResources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resourceArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_arn), input.resource_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"state\":");
    try aws.json.writeValue(@TypeOf(input.state), input.state, allocator, &body_buf);
    has_prev = true;
    if (input.update_at) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"updateAt\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartResourceStateUpdateOutput {
    const result: StartResourceStateUpdateOutput = try aws.json.parseJsonObject(
        StartResourceStateUpdateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
