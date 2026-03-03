const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Accelerators = @import("accelerators.zig").Accelerators;
const ContainerRegistryMap = @import("container_registry_map.zig").ContainerRegistryMap;
const DefinitionRepository = @import("definition_repository.zig").DefinitionRepository;
const WorkflowEngine = @import("workflow_engine.zig").WorkflowEngine;
const WorkflowParameter = @import("workflow_parameter.zig").WorkflowParameter;
const StorageType = @import("storage_type.zig").StorageType;
const WorkflowStatus = @import("workflow_status.zig").WorkflowStatus;

pub const CreateWorkflowVersionInput = struct {
    /// The computational accelerator for this workflow version.
    accelerators: ?Accelerators = null,

    /// (Optional) Use a container registry map to specify mappings between the ECR
    /// private repository and one or more upstream registries. For more
    /// information, see [Container
    /// images](https://docs.aws.amazon.com/omics/latest/dev/workflows-ecr.html) in
    /// the *Amazon Web Services HealthOmics User Guide*.
    container_registry_map: ?ContainerRegistryMap = null,

    /// (Optional) URI of the S3 location for the registry mapping file.
    container_registry_map_uri: ?[]const u8 = null,

    /// The repository information for the workflow version definition. This allows
    /// you to source your workflow version definition directly from a code
    /// repository.
    definition_repository: ?DefinitionRepository = null,

    /// The S3 URI of a definition for this workflow version. The S3 bucket must be
    /// in the same region as this workflow version.
    definition_uri: ?[]const u8 = null,

    /// A ZIP archive containing the main workflow definition file and dependencies
    /// that it imports for this workflow version. You can use a file with a
    /// ://fileb prefix instead of the Base64 string. For more information, see
    /// Workflow definition requirements in the *Amazon Web Services HealthOmics
    /// User Guide*.
    definition_zip: ?[]const u8 = null,

    /// A description for this workflow version.
    description: ?[]const u8 = null,

    /// The workflow engine for this workflow version. This is only required if you
    /// have workflow definition files from more than one engine in your zip file.
    /// Otherwise, the service can detect the engine automatically from your
    /// workflow definition.
    engine: ?WorkflowEngine = null,

    /// The path of the main definition file for this workflow version. This
    /// parameter is not required if the ZIP archive contains only one workflow
    /// definition file, or if the main definition file is named “main”. An example
    /// path is: `workflow-definition/main-file.wdl`.
    main: ?[]const u8 = null,

    /// A parameter template for this workflow version. If this field is blank,
    /// Amazon Web Services HealthOmics will automatically parse the parameter
    /// template values from your workflow definition file. To override these
    /// service generated default values, provide a parameter template. To view an
    /// example of a parameter template, see [Parameter template
    /// files](https://docs.aws.amazon.com/omics/latest/dev/parameter-templates.html) in the *Amazon Web Services HealthOmics User Guide*.
    parameter_template: ?[]const aws.map.MapEntry(WorkflowParameter) = null,

    /// The path to the workflow version parameter template JSON file within the
    /// repository. This file defines the input parameters for runs that use this
    /// workflow version. If not specified, the workflow version will be created
    /// without a parameter template.
    parameter_template_path: ?[]const u8 = null,

    /// The markdown content for the workflow version's README file. This provides
    /// documentation and usage information for users of this specific workflow
    /// version.
    readme_markdown: ?[]const u8 = null,

    /// The path to the workflow version README markdown file within the repository.
    /// This file provides documentation and usage information for the workflow. If
    /// not specified, the `README.md` file from the root directory of the
    /// repository will be used.
    readme_path: ?[]const u8 = null,

    /// The S3 URI of the README file for the workflow version. This file provides
    /// documentation and usage information for the workflow version. Requirements
    /// include:
    ///
    /// * The S3 URI must begin with `s3://USER-OWNED-BUCKET/`
    /// * The requester must have access to the S3 bucket and object.
    /// * The max README content length is 500 KiB.
    readme_uri: ?[]const u8 = null,

    /// An idempotency token to ensure that duplicate workflows are not created when
    /// Amazon Web Services HealthOmics submits retry requests.
    request_id: []const u8,

    /// The default static storage capacity (in gibibytes) for runs that use this
    /// workflow version. The `storageCapacity` can be overwritten at run time. The
    /// storage capacity is not required for runs with a `DYNAMIC` storage type.
    storage_capacity: ?i32 = null,

    /// The default storage type for runs that use this workflow version. The
    /// `storageType` can be overridden at run time. `DYNAMIC` storage dynamically
    /// scales the storage up or down, based on file system utilization. STATIC
    /// storage allocates a fixed amount of storage. For more information about
    /// dynamic and static storage types, see [Run storage
    /// types](https://docs.aws.amazon.com/omics/latest/dev/workflows-run-types.html) in the *Amazon Web Services HealthOmics User Guide*.
    storage_type: ?StorageType = null,

    /// Tags for this workflow version. You can define up to 50 tags for the
    /// workflow. For more information, see [Adding a
    /// tag](https://docs.aws.amazon.com/omics/latest/dev/add-a-tag.html) in the
    /// *Amazon Web Services HealthOmics User Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A name for the workflow version. Provide a version name that is unique for
    /// this workflow. You cannot change the name after HealthOmics creates the
    /// version.
    ///
    /// The version name must start with a letter or number and it can include
    /// upper-case and lower-case letters, numbers, hyphens, periods and
    /// underscores. The maximum length is 64 characters. You can use a simple
    /// naming scheme, such as version1, version2, version3. You can also match your
    /// workflow versions with your own internal versioning conventions, such as
    /// 2.7.0, 2.7.1, 2.7.2.
    version_name: []const u8,

    /// Amazon Web Services Id of the owner of the S3 bucket that contains the
    /// workflow definition. You need to specify this parameter if your account is
    /// not the bucket owner.
    workflow_bucket_owner_id: ?[]const u8 = null,

    /// The ID of the workflow where you are creating the new version. The
    /// `workflowId` is not the UUID.
    workflow_id: []const u8,

    pub const json_field_names = .{
        .accelerators = "accelerators",
        .container_registry_map = "containerRegistryMap",
        .container_registry_map_uri = "containerRegistryMapUri",
        .definition_repository = "definitionRepository",
        .definition_uri = "definitionUri",
        .definition_zip = "definitionZip",
        .description = "description",
        .engine = "engine",
        .main = "main",
        .parameter_template = "parameterTemplate",
        .parameter_template_path = "parameterTemplatePath",
        .readme_markdown = "readmeMarkdown",
        .readme_path = "readmePath",
        .readme_uri = "readmeUri",
        .request_id = "requestId",
        .storage_capacity = "storageCapacity",
        .storage_type = "storageType",
        .tags = "tags",
        .version_name = "versionName",
        .workflow_bucket_owner_id = "workflowBucketOwnerId",
        .workflow_id = "workflowId",
    };
};

pub const CreateWorkflowVersionOutput = struct {
    /// ARN of the workflow version.
    arn: ?[]const u8 = null,

    /// The workflow version status.
    status: ?WorkflowStatus = null,

    /// The workflow version's tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The universally unique identifier (UUID) value for this workflow version.
    uuid: ?[]const u8 = null,

    /// The workflow version name.
    version_name: ?[]const u8 = null,

    /// The workflow's ID.
    workflow_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .status = "status",
        .tags = "tags",
        .uuid = "uuid",
        .version_name = "versionName",
        .workflow_id = "workflowId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkflowVersionInput, options: Options) !CreateWorkflowVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "omics");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkflowVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/workflow/");
    try path_buf.appendSlice(allocator, input.workflow_id);
    try path_buf.appendSlice(allocator, "/version");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.accelerators) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accelerators\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.container_registry_map) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"containerRegistryMap\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.container_registry_map_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"containerRegistryMapUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.definition_repository) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"definitionRepository\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.definition_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"definitionUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.definition_zip) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"definitionZip\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.engine) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"engine\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.main) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"main\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parameter_template) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameterTemplate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parameter_template_path) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameterTemplatePath\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.readme_markdown) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"readmeMarkdown\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.readme_path) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"readmePath\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.readme_uri) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"readmeUri\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"requestId\":");
    try aws.json.writeValue(@TypeOf(input.request_id), input.request_id, allocator, &body_buf);
    has_prev = true;
    if (input.storage_capacity) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"storageCapacity\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.storage_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"storageType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"versionName\":");
    try aws.json.writeValue(@TypeOf(input.version_name), input.version_name, allocator, &body_buf);
    has_prev = true;
    if (input.workflow_bucket_owner_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"workflowBucketOwnerId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkflowVersionOutput {
    var result: CreateWorkflowVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateWorkflowVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotSupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .not_supported_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RangeNotSatisfiableException")) {
        return .{ .arena = arena, .kind = .{ .range_not_satisfiable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .request_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
