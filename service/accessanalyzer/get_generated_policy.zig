const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GeneratedPolicyResult = @import("generated_policy_result.zig").GeneratedPolicyResult;
const JobDetails = @import("job_details.zig").JobDetails;

pub const GetGeneratedPolicyInput = struct {
    /// The level of detail that you want to generate. You can specify whether to
    /// generate policies with placeholders for resource ARNs for actions that
    /// support resource level granularity in policies.
    ///
    /// For example, in the resource section of a policy, you can receive a
    /// placeholder such as `"Resource":"arn:aws:s3:::${BucketName}"` instead of
    /// `"*"`.
    include_resource_placeholders: ?bool = null,

    /// The level of detail that you want to generate. You can specify whether to
    /// generate service-level policies.
    ///
    /// IAM Access Analyzer uses `iam:servicelastaccessed` to identify services that
    /// have been used recently to create this service-level template.
    include_service_level_template: ?bool = null,

    /// The `JobId` that is returned by the `StartPolicyGeneration` operation. The
    /// `JobId` can be used with `GetGeneratedPolicy` to retrieve the generated
    /// policies or used with `CancelPolicyGeneration` to cancel the policy
    /// generation request.
    job_id: []const u8,

    pub const json_field_names = .{
        .include_resource_placeholders = "includeResourcePlaceholders",
        .include_service_level_template = "includeServiceLevelTemplate",
        .job_id = "jobId",
    };
};

pub const GetGeneratedPolicyOutput = struct {
    /// A `GeneratedPolicyResult` object that contains the generated policies and
    /// associated details.
    generated_policy_result: ?GeneratedPolicyResult = null,

    /// A `GeneratedPolicyDetails` object that contains details about the generated
    /// policy.
    job_details: ?JobDetails = null,

    pub const json_field_names = .{
        .generated_policy_result = "generatedPolicyResult",
        .job_details = "jobDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGeneratedPolicyInput, options: CallOptions) !GetGeneratedPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "access-analyzer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGeneratedPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("access-analyzer", "AccessAnalyzer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policy/generation/");
    try path_buf.appendSlice(allocator, input.job_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.include_resource_placeholders) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeResourcePlaceholders=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.include_service_level_template) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includeServiceLevelTemplate=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGeneratedPolicyOutput {
    var result: GetGeneratedPolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetGeneratedPolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
