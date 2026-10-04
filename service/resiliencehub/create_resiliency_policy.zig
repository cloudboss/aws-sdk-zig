const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataLocationConstraint = @import("data_location_constraint.zig").DataLocationConstraint;
const FailurePolicy = @import("failure_policy.zig").FailurePolicy;
const ResiliencyPolicyTier = @import("resiliency_policy_tier.zig").ResiliencyPolicyTier;
const ResiliencyPolicy = @import("resiliency_policy.zig").ResiliencyPolicy;

pub const CreateResiliencyPolicyInput = struct {
    /// Used for an idempotency token. A client token is a unique, case-sensitive
    /// string of up to 64 ASCII characters.
    /// You should not reuse the same client token for other API requests.
    client_token: ?[]const u8 = null,

    /// Specifies a high-level geographical location constraint for where your
    /// resilience policy
    /// data can be stored.
    data_location_constraint: ?DataLocationConstraint = null,

    /// The type of resiliency policy to be created, including the recovery time
    /// objective (RTO)
    /// and recovery point objective (RPO) in seconds.
    policy: []const aws.map.MapEntry(FailurePolicy),

    /// Description of the resiliency policy.
    policy_description: ?[]const u8 = null,

    /// Name of the resiliency policy.
    policy_name: []const u8,

    /// Tags assigned to the resource. A tag is a label that you assign to an Amazon
    /// Web Services resource.
    /// Each tag consists of a key/value pair.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The tier for this resiliency policy, ranging from the highest severity
    /// (`MissionCritical`) to lowest (`NonCritical`).
    tier: ResiliencyPolicyTier,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .data_location_constraint = "dataLocationConstraint",
        .policy = "policy",
        .policy_description = "policyDescription",
        .policy_name = "policyName",
        .tags = "tags",
        .tier = "tier",
    };
};

pub const CreateResiliencyPolicyOutput = struct {
    /// The type of resiliency policy that was created, including the recovery time
    /// objective
    /// (RTO) and recovery point objective (RPO) in seconds.
    policy: ?ResiliencyPolicy = null,

    pub const json_field_names = .{
        .policy = "policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResiliencyPolicyInput, options: CallOptions) !CreateResiliencyPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResiliencyPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/create-resiliency-policy";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_location_constraint) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dataLocationConstraint\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policy\":");
    try aws.json.writeValue(@TypeOf(input.policy), input.policy, allocator, &body_buf);
    has_prev = true;
    if (input.policy_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policyDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyName\":");
    try aws.json.writeValue(@TypeOf(input.policy_name), input.policy_name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"tier\":");
    try aws.json.writeValue(@TypeOf(input.tier), input.tier, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResiliencyPolicyOutput {
    const result: CreateResiliencyPolicyOutput = try aws.json.parseJsonObject(
        CreateResiliencyPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
