const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdMappingTechniques = @import("id_mapping_techniques.zig").IdMappingTechniques;
const IdMappingIncrementalRunConfig = @import("id_mapping_incremental_run_config.zig").IdMappingIncrementalRunConfig;
const IdMappingWorkflowInputSource = @import("id_mapping_workflow_input_source.zig").IdMappingWorkflowInputSource;
const IdMappingWorkflowOutputSource = @import("id_mapping_workflow_output_source.zig").IdMappingWorkflowOutputSource;

pub const GetIdMappingWorkflowInput = struct {
    /// The name of the workflow.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .workflow_name = "workflowName",
    };
};

pub const GetIdMappingWorkflowOutput = struct {
    /// The timestamp of when the workflow was created.
    created_at: i64,

    /// A description of the workflow.
    description: ?[]const u8 = null,

    /// An object which defines the ID mapping technique and any additional
    /// configurations.
    id_mapping_techniques: ?IdMappingTechniques = null,

    /// The incremental run configuration for the ID mapping workflow.
    incremental_run_config: ?IdMappingIncrementalRunConfig = null,

    /// A list of `InputSource` objects, which have the fields `InputSourceARN` and
    /// `SchemaName`.
    input_source_config: ?[]const IdMappingWorkflowInputSource = null,

    /// A list of `OutputSource` objects, each of which contains fields
    /// `outputS3Path` and `KMSArn`.
    output_source_config: ?[]const IdMappingWorkflowOutputSource = null,

    /// The Amazon Resource Name (ARN) of the IAM role. Entity Resolution assumes
    /// this role to access Amazon Web Services resources on your behalf.
    role_arn: ?[]const u8 = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp of when the workflow was last updated.
    updated_at: i64,

    /// The ARN (Amazon Resource Name) that Entity Resolution generated for the
    /// `IdMappingWorkflow` .
    workflow_arn: []const u8,

    /// The name of the workflow.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .id_mapping_techniques = "idMappingTechniques",
        .incremental_run_config = "incrementalRunConfig",
        .input_source_config = "inputSourceConfig",
        .output_source_config = "outputSourceConfig",
        .role_arn = "roleArn",
        .tags = "tags",
        .updated_at = "updatedAt",
        .workflow_arn = "workflowArn",
        .workflow_name = "workflowName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIdMappingWorkflowInput, options: CallOptions) !GetIdMappingWorkflowOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIdMappingWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/idmappingworkflows/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIdMappingWorkflowOutput {
    var result: GetIdMappingWorkflowOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetIdMappingWorkflowOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
