const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssessmentConfiguration = @import("assessment_configuration.zig").AssessmentConfiguration;

pub const StartADAssessmentInput = struct {
    /// Configuration parameters for the directory assessment, including DNS server
    /// information, domain name, Amazon VPC subnet, and Amazon Web Services System
    /// Manager managed node
    /// details.
    assessment_configuration: ?AssessmentConfiguration = null,

    /// The identifier of the directory for which to perform the assessment. This
    /// should be an
    /// existing directory. If the assessment is not for an existing directory, this
    /// parameter
    /// should be omitted.
    directory_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_configuration = "AssessmentConfiguration",
        .directory_id = "DirectoryId",
    };
};

pub const StartADAssessmentOutput = struct {
    /// The unique identifier of the newly started directory assessment. Use this
    /// identifier
    /// to monitor assessment progress and retrieve results.
    assessment_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .assessment_id = "AssessmentId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartADAssessmentInput, options: CallOptions) !StartADAssessmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartADAssessmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.StartADAssessment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartADAssessmentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartADAssessmentOutput, body, allocator);
}
