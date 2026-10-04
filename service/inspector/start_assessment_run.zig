const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartAssessmentRunInput = struct {
    /// You can specify the name for the assessment run. The name must be unique for
    /// the
    /// assessment template whose ARN is used to start the assessment run.
    assessment_run_name: ?[]const u8 = null,

    /// The ARN of the assessment template of the assessment run that you want to
    /// start.
    assessment_template_arn: []const u8,

    pub const json_field_names = .{
        .assessment_run_name = "assessmentRunName",
        .assessment_template_arn = "assessmentTemplateArn",
    };
};

pub const StartAssessmentRunOutput = struct {
    /// The ARN of the assessment run that has been started.
    assessment_run_arn: []const u8,

    pub const json_field_names = .{
        .assessment_run_arn = "assessmentRunArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAssessmentRunInput, options: CallOptions) !StartAssessmentRunOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAssessmentRunInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "InspectorService.StartAssessmentRun");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAssessmentRunOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartAssessmentRunOutput, body, allocator);
}
