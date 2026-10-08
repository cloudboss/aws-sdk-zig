const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AvailabilitySlo = @import("availability_slo.zig").AvailabilitySlo;
const MultiAzDisasterRecoveryApproach = @import("multi_az_disaster_recovery_approach.zig").MultiAzDisasterRecoveryApproach;
const MultiRegionDisasterRecoveryApproach = @import("multi_region_disaster_recovery_approach.zig").MultiRegionDisasterRecoveryApproach;
const Policy = @import("policy.zig").Policy;

pub const ImportPolicyInput = struct {
    /// The availability SLO to set on the imported policy.
    availability_slo: ?AvailabilitySlo = null,

    client_token: ?[]const u8 = null,

    kms_key_id: ?[]const u8 = null,

    /// The multi-AZ disaster recovery approach for the imported policy.
    multi_az_disaster_recovery_approach: ?MultiAzDisasterRecoveryApproach = null,

    /// The multi-Region disaster recovery approach for the imported policy.
    multi_region_disaster_recovery_approach: ?MultiRegionDisasterRecoveryApproach = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    v_1_policy_arn: []const u8,

    pub const json_field_names = .{
        .availability_slo = "availabilitySlo",
        .client_token = "clientToken",
        .kms_key_id = "kmsKeyId",
        .multi_az_disaster_recovery_approach = "multiAzDisasterRecoveryApproach",
        .multi_region_disaster_recovery_approach = "multiRegionDisasterRecoveryApproach",
        .tags = "tags",
        .v_1_policy_arn = "v1PolicyArn",
    };
};

pub const ImportPolicyOutput = struct {
    /// The imported policy.
    policy: ?Policy = null,

    pub const json_field_names = .{
        .policy = "policy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportPolicyInput, options: CallOptions) !ImportPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehubv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/import-policy";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.availability_slo) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"availabilitySlo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.multi_az_disaster_recovery_approach) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"multiAzDisasterRecoveryApproach\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.multi_region_disaster_recovery_approach) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"multiRegionDisasterRecoveryApproach\":");
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
    try body_buf.appendSlice(allocator, "\"v1PolicyArn\":");
    try aws.json.writeValue(@TypeOf(input.v_1_policy_arn), input.v_1_policy_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportPolicyOutput {
    const result: ImportPolicyOutput = try aws.json.parseJsonObject(
        ImportPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
