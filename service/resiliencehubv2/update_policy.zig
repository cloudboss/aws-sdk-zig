const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AvailabilitySlo = @import("availability_slo.zig").AvailabilitySlo;
const DataRecoveryTargets = @import("data_recovery_targets.zig").DataRecoveryTargets;
const MultiAzTargets = @import("multi_az_targets.zig").MultiAzTargets;
const MultiRegionTargets = @import("multi_region_targets.zig").MultiRegionTargets;
const Policy = @import("policy.zig").Policy;

pub const UpdatePolicyInput = struct {
    /// The updated availability SLO for the policy.
    availability_slo: ?AvailabilitySlo = null,

    /// The updated data recovery targets for the policy.
    data_recovery: ?DataRecoveryTargets = null,

    description: ?[]const u8 = null,

    /// The updated multi-AZ disaster recovery targets for the policy.
    multi_az: ?MultiAzTargets = null,

    /// The updated multi-Region disaster recovery targets for the policy.
    multi_region: ?MultiRegionTargets = null,

    policy_arn: []const u8,

    /// Specifies whether cross-account sharing is enabled for the policy. Disabling
    /// sharing stops member services from using the policy.
    sharing_enabled: ?bool = null,

    pub const json_field_names = .{
        .availability_slo = "availabilitySlo",
        .data_recovery = "dataRecovery",
        .description = "description",
        .multi_az = "multiAz",
        .multi_region = "multiRegion",
        .policy_arn = "policyArn",
        .sharing_enabled = "sharingEnabled",
    };
};

pub const UpdatePolicyOutput = struct {
    /// The updated policy.
    policy: ?Policy = null,

    pub const json_field_names = .{
        .policy = "policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePolicyInput, options: CallOptions) !UpdatePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehubv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/update-policy";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.availability_slo) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"availabilitySlo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_recovery) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dataRecovery\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.multi_az) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"multiAz\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.multi_region) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"multiRegion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyArn\":");
    try aws.json.writeValue(@TypeOf(input.policy_arn), input.policy_arn, allocator, &body_buf);
    has_prev = true;
    if (input.sharing_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sharingEnabled\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePolicyOutput {
    const result: UpdatePolicyOutput = try aws.json.parseJsonObject(
        UpdatePolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
