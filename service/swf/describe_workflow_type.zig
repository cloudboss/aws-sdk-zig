const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowType = @import("workflow_type.zig").WorkflowType;
const WorkflowTypeConfiguration = @import("workflow_type_configuration.zig").WorkflowTypeConfiguration;
const WorkflowTypeInfo = @import("workflow_type_info.zig").WorkflowTypeInfo;

pub const DescribeWorkflowTypeInput = struct {
    /// The name of the domain in which this workflow type is registered.
    domain: []const u8,

    /// The workflow type to describe.
    workflow_type: WorkflowType,

    pub const json_field_names = .{
        .domain = "domain",
        .workflow_type = "workflowType",
    };
};

pub const DescribeWorkflowTypeOutput = struct {
    /// Configuration settings of the workflow type registered through
    /// RegisterWorkflowType
    configuration: ?WorkflowTypeConfiguration = null,

    /// General information about the workflow type.
    ///
    /// The status of the workflow type (returned in the WorkflowTypeInfo structure)
    /// can be one of the following.
    ///
    /// * `REGISTERED` – The type is registered and available. Workers supporting
    ///   this type should be running.
    ///
    /// * `DEPRECATED` – The type was deprecated using DeprecateWorkflowType, but is
    ///   still in use. You should
    /// keep workers supporting this type running. You cannot create new workflow
    /// executions of this type.
    type_info: ?WorkflowTypeInfo = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .type_info = "typeInfo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeWorkflowTypeInput, options: CallOptions) !DescribeWorkflowTypeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeWorkflowTypeInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SimpleWorkflowService.DescribeWorkflowType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeWorkflowTypeOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeWorkflowTypeOutput, body, allocator);
}
