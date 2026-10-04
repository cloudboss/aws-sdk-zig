const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ErrorDetails = @import("error_details.zig").ErrorDetails;
const Progress = @import("progress.zig").Progress;
const Scope = @import("scope.zig").Scope;
const GenerationStatus = @import("generation_status.zig").GenerationStatus;

pub const GetAgentRecommendationGenerationInput = struct {
    /// The unique identifier of the recommendation generation to retrieve.
    generation_id: []const u8,

    /// The ARN of the optimization profile associated with this generation.
    profile_arn: []const u8,

    pub const json_field_names = .{
        .generation_id = "generationId",
        .profile_arn = "profileArn",
    };
};

pub const GetAgentRecommendationGenerationOutput = struct {
    /// Additional context information provided to guide the recommendation
    /// generation process.
    additional_context: ?[]const u8 = null,

    /// The timestamp when the generation was started.
    created_at: i64,

    /// The identifier of the user or system that started this generation.
    created_by: []const u8,

    /// The timestamp when the recommendation generation process completed.
    ended_at: ?i64 = null,

    /// Details about the error if the generation status is ERROR.
    error_details: ?ErrorDetails = null,

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

    /// Current progress information including steps completed and completion
    /// percentage.
    progress: ?Progress = null,

    /// The scope configuration that defines which pillars and goals to focus on
    /// during generation.
    scope: ?Scope = null,

    /// The timestamp when the recommendation generation process started.
    started_at: ?i64 = null,

    /// The current status of the recommendation generation.
    status: GenerationStatus,

    pub const json_field_names = .{
        .additional_context = "additionalContext",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .ended_at = "endedAt",
        .error_details = "errorDetails",
        .estimated_completion_time = "estimatedCompletionTime",
        .id = "id",
        .last_modified_at = "lastModifiedAt",
        .last_modified_by = "lastModifiedBy",
        .name = "name",
        .profile_arn = "profileArn",
        .progress = "progress",
        .scope = "scope",
        .started_at = "startedAt",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAgentRecommendationGenerationInput, options: CallOptions) !GetAgentRecommendationGenerationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAgentRecommendationGenerationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/api/v1/agent-profiles/");
    try path_buf.appendSlice(allocator, input.profile_arn);
    try path_buf.appendSlice(allocator, "/generations/");
    try path_buf.appendSlice(allocator, input.generation_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAgentRecommendationGenerationOutput {
    const result: GetAgentRecommendationGenerationOutput = try aws.json.parseJsonObject(
        GetAgentRecommendationGenerationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
