const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataLocationConstraint = @import("data_location_constraint.zig").DataLocationConstraint;
const FailurePolicy = @import("failure_policy.zig").FailurePolicy;
const ResiliencyPolicyTier = @import("resiliency_policy_tier.zig").ResiliencyPolicyTier;
const ResiliencyPolicy = @import("resiliency_policy.zig").ResiliencyPolicy;

pub const UpdateResiliencyPolicyInput = struct {
    /// Specifies a high-level geographical location constraint for where your
    /// resilience policy data can be stored.
    data_location_constraint: ?DataLocationConstraint = null,

    /// Resiliency policy to be created, including the recovery time objective (RTO)
    /// and recovery point objective (RPO) in seconds.
    policy: ?[]const aws.map.MapEntry(FailurePolicy) = null,

    /// Amazon Resource Name (ARN) of the resiliency policy. The format for this ARN
    /// is:
    /// arn:`partition`:resiliencehub:`region`:`account`:resiliency-policy/`policy-id`. For more information about ARNs,
    /// see [
    /// Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the
    /// *Amazon Web Services General Reference* guide.
    policy_arn: []const u8,

    /// Description of the resiliency policy.
    policy_description: ?[]const u8 = null,

    /// Name of the resiliency policy.
    policy_name: ?[]const u8 = null,

    /// The tier for this resiliency policy, ranging from the highest severity
    /// (`MissionCritical`) to lowest (`NonCritical`).
    tier: ?ResiliencyPolicyTier = null,

    pub const json_field_names = .{
        .data_location_constraint = "dataLocationConstraint",
        .policy = "policy",
        .policy_arn = "policyArn",
        .policy_description = "policyDescription",
        .policy_name = "policyName",
        .tier = "tier",
    };
};

pub const UpdateResiliencyPolicyOutput = struct {
    /// The resiliency policy that was updated, including the recovery time
    /// objective
    /// (RTO) and recovery point objective (RPO) in seconds.
    policy: ?ResiliencyPolicy = null,

    pub const json_field_names = .{
        .policy = "policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateResiliencyPolicyInput, options: CallOptions) !UpdateResiliencyPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateResiliencyPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/update-resiliency-policy";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.data_location_constraint) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dataLocationConstraint\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyArn\":");
    try aws.json.writeValue(@TypeOf(input.policy_arn), input.policy_arn, allocator, &body_buf);
    has_prev = true;
    if (input.policy_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policyDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.policy_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policyName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateResiliencyPolicyOutput {
    const result: UpdateResiliencyPolicyOutput = try aws.json.parseJsonObject(
        UpdateResiliencyPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
