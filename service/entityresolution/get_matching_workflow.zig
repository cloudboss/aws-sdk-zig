const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IncrementalRunConfig = @import("incremental_run_config.zig").IncrementalRunConfig;
const InputSource = @import("input_source.zig").InputSource;
const OutputSource = @import("output_source.zig").OutputSource;
const ResolutionTechniques = @import("resolution_techniques.zig").ResolutionTechniques;

pub const GetMatchingWorkflowInput = struct {
    /// The name of the workflow.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .workflow_name = "workflowName",
    };
};

pub const GetMatchingWorkflowOutput = struct {
    /// The timestamp of when the workflow was created.
    created_at: i64,

    /// A description of the workflow.
    description: ?[]const u8 = null,

    /// An object which defines an incremental run type and has only
    /// `incrementalRunType` as a field.
    incremental_run_config: ?IncrementalRunConfig = null,

    /// A list of `InputSource` objects, which have the fields `InputSourceARN` and
    /// `SchemaName`.
    input_source_config: ?[]const InputSource = null,

    /// A list of `OutputSource` objects, each of which contains fields
    /// `outputS3Path`, `applyNormalization`, `KMSArn`, and `output`.
    output_source_config: ?[]const OutputSource = null,

    /// An object which defines the `resolutionType` and the `ruleBasedProperties`.
    resolution_techniques: ?ResolutionTechniques = null,

    /// The Amazon Resource Name (ARN) of the IAM role. Entity Resolution assumes
    /// this role to access Amazon Web Services resources on your behalf.
    role_arn: []const u8,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp of when the workflow was last updated.
    updated_at: i64,

    /// The ARN (Amazon Resource Name) that Entity Resolution generated for the
    /// `MatchingWorkflow`.
    workflow_arn: []const u8,

    /// The name of the workflow.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .incremental_run_config = "incrementalRunConfig",
        .input_source_config = "inputSourceConfig",
        .output_source_config = "outputSourceConfig",
        .resolution_techniques = "resolutionTechniques",
        .role_arn = "roleArn",
        .tags = "tags",
        .updated_at = "updatedAt",
        .workflow_arn = "workflowArn",
        .workflow_name = "workflowName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMatchingWorkflowInput, options: CallOptions) !GetMatchingWorkflowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "entityresolution", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMatchingWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/matchingworkflows/");
    try path_buf.appendSlice(allocator, input.workflow_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMatchingWorkflowOutput {
    var result: GetMatchingWorkflowOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetMatchingWorkflowOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
