const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkflowExport = @import("workflow_export.zig").WorkflowExport;
const WorkflowType = @import("workflow_type.zig").WorkflowType;
const Accelerators = @import("accelerators.zig").Accelerators;
const ContainerRegistryMap = @import("container_registry_map.zig").ContainerRegistryMap;
const DefinitionRepositoryDetails = @import("definition_repository_details.zig").DefinitionRepositoryDetails;
const WorkflowEngine = @import("workflow_engine.zig").WorkflowEngine;
const WorkflowParameter = @import("workflow_parameter.zig").WorkflowParameter;
const WorkflowStatus = @import("workflow_status.zig").WorkflowStatus;
const StorageType = @import("storage_type.zig").StorageType;

pub const GetWorkflowInput = struct {
    /// The export format for the workflow.
    @"export": ?[]const WorkflowExport = null,

    /// The workflow's ID.
    id: []const u8,

    /// The workflow's type.
    type: ?WorkflowType = null,

    /// The ID of the workflow owner.
    workflow_owner_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .@"export" = "export",
        .id = "id",
        .type = "type",
        .workflow_owner_id = "workflowOwnerId",
    };
};

pub const GetWorkflowOutput = struct {
    /// The computational accelerator specified to run the workflow.
    accelerators: ?Accelerators = null,

    /// The workflow's ARN.
    arn: ?[]const u8 = null,

    /// The registry map that this workflow is using.
    container_registry_map: ?ContainerRegistryMap = null,

    /// When the workflow was created.
    creation_time: ?i64 = null,

    /// The workflow's definition.
    definition: ?[]const u8 = null,

    /// Details about the source code repository that hosts the workflow definition
    /// files.
    definition_repository_details: ?DefinitionRepositoryDetails = null,

    /// The workflow's description.
    description: ?[]const u8 = null,

    /// The workflow's digest.
    digest: ?[]const u8 = null,

    /// The workflow's engine.
    engine: ?WorkflowEngine = null,

    /// The workflow's ID.
    id: ?[]const u8 = null,

    /// The path of the main definition file for the workflow.
    main: ?[]const u8 = null,

    /// Gets metadata for the workflow.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The workflow's name.
    name: ?[]const u8 = null,

    /// The workflow's parameter template.
    parameter_template: ?[]const aws.map.MapEntry(WorkflowParameter) = null,

    /// A mapping of profile names to their parameter templates. Each profile
    /// defines its own set of parameters that you can use when starting a run with
    /// that profile.
    profile_parameter_templates: ?[]const aws.map.MapEntry([]const aws.map.MapEntry(WorkflowParameter)) = null,

    /// The list of Nextflow profiles that are available for this workflow. Profiles
    /// allow you to select predefined configuration settings at runtime.
    profiles: ?[]const []const u8 = null,

    /// The README content for the workflow, providing documentation and usage
    /// information.
    readme: ?[]const u8 = null,

    /// The path to the workflow README markdown file within the repository. This
    /// file provides documentation and usage information for the workflow. If not
    /// specified, the `README.md` file from the root directory of the repository
    /// will be used.
    readme_path: ?[]const u8 = null,

    /// The workflow's status.
    status: ?WorkflowStatus = null,

    /// The workflow's status message.
    status_message: ?[]const u8 = null,

    /// The default static storage capacity (in gibibytes) for runs that use this
    /// workflow or workflow version.
    storage_capacity: ?i32 = null,

    /// The default storage type for runs using this workflow.
    storage_type: ?StorageType = null,

    /// The workflow's tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The workflow's type.
    type: ?WorkflowType = null,

    /// The universally unique identifier (UUID) value for this workflow.
    uuid: ?[]const u8 = null,

    pub const json_field_names = .{
        .accelerators = "accelerators",
        .arn = "arn",
        .container_registry_map = "containerRegistryMap",
        .creation_time = "creationTime",
        .definition = "definition",
        .definition_repository_details = "definitionRepositoryDetails",
        .description = "description",
        .digest = "digest",
        .engine = "engine",
        .id = "id",
        .main = "main",
        .metadata = "metadata",
        .name = "name",
        .parameter_template = "parameterTemplate",
        .profile_parameter_templates = "profileParameterTemplates",
        .profiles = "profiles",
        .readme = "readme",
        .readme_path = "readmePath",
        .status = "status",
        .status_message = "statusMessage",
        .storage_capacity = "storageCapacity",
        .storage_type = "storageType",
        .tags = "tags",
        .type = "type",
        .uuid = "uuid",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWorkflowInput, options: CallOptions) !GetWorkflowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workflow/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.@"export") |v| {
        for (v) |item| {
            if (query_has_prev) try query_buf.appendSlice(allocator, "&");
            try query_buf.appendSlice(allocator, "export=");
            try aws.url.appendUrlEncoded(allocator, &query_buf, item.wireName());
            query_has_prev = true;
        }
    }
    if (input.type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "type=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.workflow_owner_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "workflowOwnerId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWorkflowOutput {
    const result: GetWorkflowOutput = try aws.json.parseJsonObject(
        GetWorkflowOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
