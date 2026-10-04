const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateRecommendationLifecycleStage = @import("update_recommendation_lifecycle_stage.zig").UpdateRecommendationLifecycleStage;
const UpdateRecommendationLifecycleStageReasonCode = @import("update_recommendation_lifecycle_stage_reason_code.zig").UpdateRecommendationLifecycleStageReasonCode;

pub const UpdateOrganizationRecommendationLifecycleInput = struct {
    /// The new lifecycle stage
    lifecycle_stage: UpdateRecommendationLifecycleStage,

    /// The Recommendation identifier for AWS Trusted Advisor Priority
    /// recommendations
    organization_recommendation_identifier: []const u8,

    /// Reason for the lifecycle stage change
    update_reason: ?[]const u8 = null,

    /// Reason code for the lifecycle state change
    update_reason_code: ?UpdateRecommendationLifecycleStageReasonCode = null,

    pub const json_field_names = .{
        .lifecycle_stage = "lifecycleStage",
        .organization_recommendation_identifier = "organizationRecommendationIdentifier",
        .update_reason = "updateReason",
        .update_reason_code = "updateReasonCode",
    };
};

pub const UpdateOrganizationRecommendationLifecycleOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateOrganizationRecommendationLifecycleInput, options: CallOptions) !UpdateOrganizationRecommendationLifecycleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "trustedadvisor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateOrganizationRecommendationLifecycleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("trustedadvisor", "TrustedAdvisor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/organization-recommendations/");
    try path_buf.appendSlice(allocator, input.organization_recommendation_identifier);
    try path_buf.appendSlice(allocator, "/lifecycle");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"lifecycleStage\":");
    try aws.json.writeValue(@TypeOf(input.lifecycle_stage), input.lifecycle_stage, allocator, &body_buf);
    has_prev = true;
    if (input.update_reason) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"updateReason\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.update_reason_code) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"updateReasonCode\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateOrganizationRecommendationLifecycleOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateOrganizationRecommendationLifecycleOutput = .{};

    return result;
}
