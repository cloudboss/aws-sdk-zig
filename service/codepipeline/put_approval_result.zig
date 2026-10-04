const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApprovalResult = @import("approval_result.zig").ApprovalResult;

pub const PutApprovalResultInput = struct {
    /// The name of the action for which approval is requested.
    action_name: []const u8,

    /// The name of the pipeline that contains the action.
    pipeline_name: []const u8,

    /// Represents information about the result of the approval request.
    result: ApprovalResult,

    /// The name of the stage that contains the action.
    stage_name: []const u8,

    /// The system-generated token used to identify a unique approval request. The
    /// token
    /// for each open approval request can be obtained using the GetPipelineState
    /// action. It is used to validate that the approval
    /// request corresponding to this token is still valid.
    ///
    /// For a pipeline where the execution mode is set to PARALLEL, the token
    /// required to
    /// approve/reject an approval request as detailed above is not available.
    /// Instead, use
    /// the `externalExecutionId` in the response output from the
    /// ListActionExecutions action as the token in the approval
    /// request.
    token: []const u8,

    pub const json_field_names = .{
        .action_name = "actionName",
        .pipeline_name = "pipelineName",
        .result = "result",
        .stage_name = "stageName",
        .token = "token",
    };
};

pub const PutApprovalResultOutput = struct {
    /// The timestamp showing when the approval or rejection was submitted.
    approved_at: ?i64 = null,

    pub const json_field_names = .{
        .approved_at = "approvedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutApprovalResultInput, options: CallOptions) !PutApprovalResultOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codepipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutApprovalResultInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codepipeline", "CodePipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.PutApprovalResult");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutApprovalResultOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutApprovalResultOutput, body, allocator);
}
