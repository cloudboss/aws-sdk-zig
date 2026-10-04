const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateAssessmentTargetInput = struct {
    /// The user-defined name that identifies the assessment target that you want to
    /// create.
    /// The name must be unique within the AWS account.
    assessment_target_name: []const u8,

    /// The ARN that specifies the resource group that is used to create the
    /// assessment
    /// target. If resourceGroupArn is not specified, all EC2 instances in the
    /// current AWS account
    /// and region are included in the assessment target.
    resource_group_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_target_name = "assessmentTargetName",
        .resource_group_arn = "resourceGroupArn",
    };
};

pub const CreateAssessmentTargetOutput = struct {
    /// The ARN that specifies the assessment target that is created.
    assessment_target_arn: []const u8,

    pub const json_field_names = .{
        .assessment_target_arn = "assessmentTargetArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAssessmentTargetInput, options: CallOptions) !CreateAssessmentTargetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAssessmentTargetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "InspectorService.CreateAssessmentTarget");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAssessmentTargetOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateAssessmentTargetOutput, body, allocator);
}
