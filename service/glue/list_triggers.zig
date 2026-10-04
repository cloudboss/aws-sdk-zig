const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListTriggersInput = struct {
    /// The name of the job for which to retrieve triggers. The trigger that can
    /// start this job
    /// is returned. If there is no such trigger, all triggers are returned.
    dependent_job_name: ?[]const u8 = null,

    /// The maximum size of a list to return.
    max_results: ?i32 = null,

    /// A continuation token, if this is a continuation request.
    next_token: ?[]const u8 = null,

    /// Specifies to return only these tagged resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .dependent_job_name = "DependentJobName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .tags = "Tags",
    };
};

pub const ListTriggersOutput = struct {
    /// A continuation token, if the returned list does not contain the
    /// last metric available.
    next_token: ?[]const u8 = null,

    /// The names of all triggers in the account, or the triggers with the specified
    /// tags.
    trigger_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .trigger_names = "TriggerNames",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTriggersInput, options: CallOptions) !ListTriggersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTriggersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.ListTriggers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTriggersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTriggersOutput, body, allocator);
}
