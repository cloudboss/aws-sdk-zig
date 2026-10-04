const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RepositoryTrigger = @import("repository_trigger.zig").RepositoryTrigger;
const RepositoryTriggerExecutionFailure = @import("repository_trigger_execution_failure.zig").RepositoryTriggerExecutionFailure;

pub const TestRepositoryTriggersInput = struct {
    /// The name of the repository in which to test the triggers.
    repository_name: []const u8,

    /// The list of triggers to test.
    triggers: []const RepositoryTrigger,

    pub const json_field_names = .{
        .repository_name = "repositoryName",
        .triggers = "triggers",
    };
};

pub const TestRepositoryTriggersOutput = struct {
    /// The list of triggers that were not tested. This list provides the names of
    /// the
    /// triggers that could not be tested, separated by commas.
    failed_executions: ?[]const RepositoryTriggerExecutionFailure = null,

    /// The list of triggers that were successfully tested. This list provides the
    /// names of the triggers that were successfully tested, separated by commas.
    successful_executions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .failed_executions = "failedExecutions",
        .successful_executions = "successfulExecutions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestRepositoryTriggersInput, options: CallOptions) !TestRepositoryTriggersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecommit", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TestRepositoryTriggersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecommit", "CodeCommit", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.TestRepositoryTriggers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestRepositoryTriggersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(TestRepositoryTriggersOutput, body, allocator);
}
