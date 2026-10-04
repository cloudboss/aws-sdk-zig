const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssessmentTarget = @import("assessment_target.zig").AssessmentTarget;
const DataCollectionDetails = @import("data_collection_details.zig").DataCollectionDetails;

pub const GetAssessmentInput = struct {
    /// The `assessmentid` returned by StartAssessment.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetAssessmentOutput = struct {
    /// List of criteria for assessment.
    assessment_targets: ?[]const AssessmentTarget = null,

    /// Detailed information about the assessment.
    data_collection_details: ?DataCollectionDetails = null,

    /// The ID for the specific assessment task.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_targets = "assessmentTargets",
        .data_collection_details = "dataCollectionDetails",
        .id = "id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAssessmentInput, options: CallOptions) !GetAssessmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsmigrationhubstrategyrecommendation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAssessmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-strategy", "MigrationHubStrategy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/get-assessment/");
    try path_buf.appendSlice(allocator, input.id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAssessmentOutput {
    var result: GetAssessmentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAssessmentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
