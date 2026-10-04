const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RepositoryTrigger = @import("repository_trigger.zig").RepositoryTrigger;

pub const PutRepositoryTriggersInput = struct {
    /// The name of the repository where you want to create or update the trigger.
    repository_name: []const u8,

    /// The JSON block of configuration information for each trigger.
    triggers: []const RepositoryTrigger,

    pub const json_field_names = .{
        .repository_name = "repositoryName",
        .triggers = "triggers",
    };
};

pub const PutRepositoryTriggersOutput = struct {
    /// The system-generated unique ID for the create or update operation.
    configuration_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration_id = "configurationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRepositoryTriggersInput, options: CallOptions) !PutRepositoryTriggersOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRepositoryTriggersInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.PutRepositoryTriggers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRepositoryTriggersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PutRepositoryTriggersOutput, body, allocator);
}
