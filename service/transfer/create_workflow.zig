const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowStep = @import("workflow_step.zig").WorkflowStep;
const Tag = @import("tag.zig").Tag;

pub const CreateWorkflowInput = struct {
    /// A textual description for the workflow.
    description: ?[]const u8 = null,

    /// Specifies the steps (actions) to take if errors are encountered during
    /// execution of the workflow.
    ///
    /// For custom steps, the Lambda function needs to send `FAILURE` to the call
    /// back API to kick off the exception steps. Additionally, if the Lambda does
    /// not send `SUCCESS` before it times out, the exception steps are executed.
    on_exception_steps: ?[]const WorkflowStep = null,

    /// Specifies the details for the steps that are in the specified workflow.
    ///
    /// The `TYPE` specifies which of the following actions is being taken for this
    /// step.
    ///
    /// * ** `COPY` ** - Copy the file to another location.
    /// * ** `CUSTOM` ** - Perform a custom step with an Lambda function target.
    /// * ** `DECRYPT` ** - Decrypt a file that was encrypted before it was
    ///   uploaded.
    /// * ** `DELETE` ** - Delete the file.
    /// * ** `TAG` ** - Add a tag to the file.
    ///
    /// Currently, copying and tagging are supported only on S3.
    ///
    /// For file location, you specify either the Amazon S3 bucket and key, or the
    /// Amazon EFS file system ID and path.
    steps: []const WorkflowStep,

    /// Specifies the log groups to which your workflow logs are sent.
    ///
    /// To specify a log group, you must provide the ARN for an existing log group.
    /// In this case, the format of the log group is as follows:
    ///
    /// `arn:partition:logs:region-name:amazon-account-id:log-group:log-group-name:*`
    ///
    /// For example, `arn:aws:logs:us-east-1:111122223333:log-group:mytestgroup:*`
    structured_log_destinations: ?[]const []const u8 = null,

    /// Key-value pairs that can be used to group and search for workflows. Tags are
    /// metadata attached to workflows for any purpose.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "Description",
        .on_exception_steps = "OnExceptionSteps",
        .steps = "Steps",
        .structured_log_destinations = "StructuredLogDestinations",
        .tags = "Tags",
    };
};

pub const CreateWorkflowOutput = struct {
    /// A unique identifier for the workflow.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .workflow_id = "WorkflowId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkflowInput, options: CallOptions) !CreateWorkflowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transfer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transfer", "Transfer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "TransferService.CreateWorkflow");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkflowOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateWorkflowOutput, body, allocator);
}
