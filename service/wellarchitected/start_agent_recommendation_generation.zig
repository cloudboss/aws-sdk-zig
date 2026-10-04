const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Scope = @import("scope.zig").Scope;
const RecommendationType = @import("recommendation_type.zig").RecommendationType;
const GenerationStatus = @import("generation_status.zig").GenerationStatus;

pub const StartAgentRecommendationGenerationInput = struct {
    /// Optional additional context to guide the recommendation generation, such as
    /// specific business requirements or constraints.
    additional_context: ?[]const u8 = null,

    /// An optional name for this generation process to help identify it in lists
    /// and logs.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the optimization profile to use for
    /// generating recommendations.
    profile_arn: []const u8,

    /// Scope configuration to focus the generation on specific pillars or goals.
    scope: Scope,

    /// The types of recommendations to generate.
    types: []const RecommendationType,

    pub const json_field_names = .{
        .additional_context = "additionalContext",
        .name = "name",
        .profile_arn = "profileArn",
        .scope = "scope",
        .types = "types",
    };
};

pub const StartAgentRecommendationGenerationOutput = struct {
    /// The timestamp when the generation was started.
    created_at: i64,

    /// The identifier of the user or system that started this generation.
    created_by: []const u8,

    /// The estimated time for the generation to complete.
    estimated_completion_time: ?i64 = null,

    /// The unique identifier of the recommendation generation.
    id: []const u8,

    /// The timestamp when the generation was last modified.
    last_modified_at: ?i64 = null,

    /// The identifier of the user or system that last modified this generation.
    last_modified_by: ?[]const u8 = null,

    /// The name of the recommendation generation.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the profile used for this generation.
    profile_arn: []const u8,

    /// The current status of the recommendation generation.
    status: GenerationStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .estimated_completion_time = "estimatedCompletionTime",
        .id = "id",
        .last_modified_at = "lastModifiedAt",
        .last_modified_by = "lastModifiedBy",
        .name = "name",
        .profile_arn = "profileArn",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAgentRecommendationGenerationInput, options: CallOptions) !StartAgentRecommendationGenerationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wellarchitected", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAgentRecommendationGenerationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/v1/agent-profiles/");
    try path_buf.appendSlice(allocator, input.profile_arn);
    try path_buf.appendSlice(allocator, "/generations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.additional_context) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"additionalContext\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scope\":");
    try aws.json.writeValue(@TypeOf(input.scope), input.scope, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"types\":");
    try aws.json.writeValue(@TypeOf(input.types), input.types, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAgentRecommendationGenerationOutput {
    const result: StartAgentRecommendationGenerationOutput = try aws.json.parseJsonObject(
        StartAgentRecommendationGenerationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
