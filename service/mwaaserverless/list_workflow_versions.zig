const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowVersionSummary = @import("workflow_version_summary.zig").WorkflowVersionSummary;

pub const ListWorkflowVersionsInput = struct {
    /// The maximum number of workflow versions to return in a single response.
    max_results: ?i32 = null,

    /// The pagination token you need to use to retrieve the next set of results.
    /// This value is returned from a previous call to `ListWorkflowVersions`.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the workflow for which you want to list
    /// versions.
    workflow_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .workflow_arn = "WorkflowArn",
    };
};

pub const ListWorkflowVersionsOutput = struct {
    /// The pagination token you need to use to retrieve the next set of results.
    /// This value is null if there are no more results.
    next_token: ?[]const u8 = null,

    /// A list of workflow version summaries for the specified workflow.
    workflow_versions: ?[]const WorkflowVersionSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .workflow_versions = "WorkflowVersions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWorkflowVersionsInput, options: CallOptions) !ListWorkflowVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "airflow-serverless", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWorkflowVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("airflow-serverless", "MWAA Serverless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMWAAServerless.ListWorkflowVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWorkflowVersionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListWorkflowVersionsOutput, body, allocator);
}
