const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecordOutput = @import("record_output.zig").RecordOutput;
const EngineWorkflowStatus = @import("engine_workflow_status.zig").EngineWorkflowStatus;

pub const NotifyUpdateProvisionedProductEngineWorkflowResultInput = struct {
    /// The reason
    /// why the update engine execution failed.
    failure_reason: ?[]const u8 = null,

    /// The idempotency token
    /// that identifies the update engine execution.
    idempotency_token: []const u8,

    /// The output
    /// of the update engine execution.
    outputs: ?[]const RecordOutput = null,

    /// The identifier
    /// of the record.
    record_id: []const u8,

    /// The status
    /// of the update engine execution.
    status: EngineWorkflowStatus,

    /// The encrypted contents
    /// of the update engine execution payload
    /// that Service Catalog sends
    /// after the Terraform product update workflow starts.
    workflow_token: []const u8,

    pub const json_field_names = .{
        .failure_reason = "FailureReason",
        .idempotency_token = "IdempotencyToken",
        .outputs = "Outputs",
        .record_id = "RecordId",
        .status = "Status",
        .workflow_token = "WorkflowToken",
    };
};

pub const NotifyUpdateProvisionedProductEngineWorkflowResultOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: NotifyUpdateProvisionedProductEngineWorkflowResultInput, options: CallOptions) !NotifyUpdateProvisionedProductEngineWorkflowResultOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicecatalog", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: NotifyUpdateProvisionedProductEngineWorkflowResultInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog", "Service Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.NotifyUpdateProvisionedProductEngineWorkflowResult");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !NotifyUpdateProvisionedProductEngineWorkflowResultOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
