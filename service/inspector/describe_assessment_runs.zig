const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssessmentRun = @import("assessment_run.zig").AssessmentRun;
const FailedItemDetails = @import("failed_item_details.zig").FailedItemDetails;

pub const DescribeAssessmentRunsInput = struct {
    /// The ARN that specifies the assessment run that you want to describe.
    assessment_run_arns: []const []const u8,

    pub const json_field_names = .{
        .assessment_run_arns = "assessmentRunArns",
    };
};

pub const DescribeAssessmentRunsOutput = struct {
    /// Information about the assessment run.
    assessment_runs: ?[]const AssessmentRun = null,

    /// Assessment run details that cannot be described. An error code is provided
    /// for each
    /// failed item.
    failed_items: ?[]const aws.map.MapEntry(FailedItemDetails) = null,

    pub const json_field_names = .{
        .assessment_runs = "assessmentRuns",
        .failed_items = "failedItems",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAssessmentRunsInput, options: CallOptions) !DescribeAssessmentRunsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAssessmentRunsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector", "Inspector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "InspectorService.DescribeAssessmentRuns");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAssessmentRunsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeAssessmentRunsOutput, body, allocator);
}
