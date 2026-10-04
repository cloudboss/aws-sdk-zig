const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LanguageCode = @import("language_code.zig").LanguageCode;
const ActivityReward = @import("activity_reward.zig").ActivityReward;
const ActivityStatus = @import("activity_status.zig").ActivityStatus;

pub const GetAccountActivityInput = struct {
    /// A unique identifier that identifies the activity.
    activity_id: []const u8,

    /// The language code used to return translated title and description fields.
    language_code: ?LanguageCode = null,

    pub const json_field_names = .{
        .activity_id = "activityId",
        .language_code = "languageCode",
    };
};

pub const GetAccountActivityOutput = struct {
    /// A unique identifier that identifies the activity.
    activity_id: []const u8,

    /// The timestamp when the activity is completed. This field appears only for
    /// activities in the `COMPLETED` state.
    completed_at: ?i64 = null,

    /// Provides detailed information about the activity and its expected outcomes.
    description: []const u8,

    /// The estimated time to complete the activity. This is the duration in
    /// minutes.
    estimated_time_to_complete_in_minutes: ?i32 = null,

    /// The time by which the activity must be completed to receive a reward.
    expires_at: ?i64 = null,

    /// The URL resource that provides guidance on activity requirements and
    /// completion.
    instructions_url: []const u8,

    /// A reward granted upon activity completion.
    reward: ?ActivityReward = null,

    /// The timestamp when the activity started. This field appears only for
    /// activities in the `IN_PROGRESS` or `COMPLETED` states.
    started_at: ?i64 = null,

    /// The current activity status.
    status: ActivityStatus,

    /// A short activity title.
    title: []const u8,

    pub const json_field_names = .{
        .activity_id = "activityId",
        .completed_at = "completedAt",
        .description = "description",
        .estimated_time_to_complete_in_minutes = "estimatedTimeToCompleteInMinutes",
        .expires_at = "expiresAt",
        .instructions_url = "instructionsUrl",
        .reward = "reward",
        .started_at = "startedAt",
        .status = "status",
        .title = "title",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccountActivityInput, options: CallOptions) !GetAccountActivityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsfreetierservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccountActivityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("freetier", "FreeTier", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFreeTierService.GetAccountActivity");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccountActivityOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetAccountActivityOutput, body, allocator);
}
