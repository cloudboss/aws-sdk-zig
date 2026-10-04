const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const RegisterDomainInput = struct {
    /// A text description of the domain.
    description: ?[]const u8 = null,

    /// Name of the domain to register. The name must be unique in the region that
    /// the domain
    /// is registered in.
    ///
    /// The specified string must not start or end with whitespace. It must not
    /// contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    name: []const u8,

    /// Tags to be added when registering a domain.
    ///
    /// Tags may only contain unicode letters, digits, whitespace, or these symbols:
    /// `_ . : / = + - @`.
    tags: ?[]const ResourceTag = null,

    /// The duration (in days) that records and histories of workflow executions on
    /// the domain
    /// should be kept by the service. After the retention period, the workflow
    /// execution isn't
    /// available in the results of visibility calls.
    ///
    /// If you pass the value `NONE` or `0` (zero), then the workflow
    /// execution history isn't retained. As soon as the workflow execution
    /// completes, the execution
    /// record and its history are deleted.
    ///
    /// The maximum workflow execution retention period is 90 days. For more
    /// information about
    /// Amazon SWF service limits, see: [Amazon SWF Service
    /// Limits](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dg-limits.html) in the
    /// *Amazon SWF Developer Guide*.
    workflow_execution_retention_period_in_days: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .tags = "tags",
        .workflow_execution_retention_period_in_days = "workflowExecutionRetentionPeriodInDays",
    };
};

pub const RegisterDomainOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterDomainInput, options: CallOptions) !RegisterDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "swf", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("swf", "SWF", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.RegisterDomain");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterDomainOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
