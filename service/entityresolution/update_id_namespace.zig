const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IdNamespaceIdMappingWorkflowProperties = @import("id_namespace_id_mapping_workflow_properties.zig").IdNamespaceIdMappingWorkflowProperties;
const IdNamespaceInputSource = @import("id_namespace_input_source.zig").IdNamespaceInputSource;
const IdNamespaceType = @import("id_namespace_type.zig").IdNamespaceType;

pub const UpdateIdNamespaceInput = struct {
    /// The description of the ID namespace.
    description: ?[]const u8 = null,

    /// Determines the properties of `IdMappingWorkflow` where this `IdNamespace`
    /// can be used as a `Source` or a `Target`.
    id_mapping_workflow_properties: ?[]const IdNamespaceIdMappingWorkflowProperties = null,

    /// The name of the ID namespace.
    id_namespace_name: []const u8,

    /// A list of `InputSource` objects, which have the fields `InputSourceARN` and
    /// `SchemaName`.
    input_source_config: ?[]const IdNamespaceInputSource = null,

    /// The Amazon Resource Name (ARN) of the IAM role. Entity Resolution assumes
    /// this role to access the resources defined in this `IdNamespace` on your
    /// behalf as part of a workflow run.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .id_mapping_workflow_properties = "idMappingWorkflowProperties",
        .id_namespace_name = "idNamespaceName",
        .input_source_config = "inputSourceConfig",
        .role_arn = "roleArn",
    };
};

pub const UpdateIdNamespaceOutput = struct {
    /// The timestamp of when the ID namespace was created.
    created_at: i64,

    /// The description of the ID namespace.
    description: ?[]const u8 = null,

    /// Determines the properties of `IdMappingWorkflow` where this `IdNamespace`
    /// can be used as a `Source` or a `Target`.
    id_mapping_workflow_properties: ?[]const IdNamespaceIdMappingWorkflowProperties = null,

    /// The Amazon Resource Name (ARN) of the ID namespace.
    id_namespace_arn: []const u8,

    /// The name of the ID namespace.
    id_namespace_name: []const u8,

    /// A list of `InputSource` objects, which have the fields `InputSourceARN` and
    /// `SchemaName`.
    input_source_config: ?[]const IdNamespaceInputSource = null,

    /// The Amazon Resource Name (ARN) of the IAM role. Entity Resolution assumes
    /// this role to access the resources defined in this `IdNamespace` on your
    /// behalf as part of a workflow run.
    role_arn: ?[]const u8 = null,

    /// The type of ID namespace. There are two types: `SOURCE` and `TARGET`.
    ///
    /// The `SOURCE` contains configurations for `sourceId` data that will be
    /// processed in an ID mapping workflow.
    ///
    /// The `TARGET` contains a configuration of `targetId` to which all `sourceIds`
    /// will resolve to.
    @"type": IdNamespaceType,

    /// The timestamp of when the ID namespace was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .id_mapping_workflow_properties = "idMappingWorkflowProperties",
        .id_namespace_arn = "idNamespaceArn",
        .id_namespace_name = "idNamespaceName",
        .input_source_config = "inputSourceConfig",
        .role_arn = "roleArn",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIdNamespaceInput, options: CallOptions) !UpdateIdNamespaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIdNamespaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/idnamespaces/");
    try path_buf.appendSlice(allocator, input.id_namespace_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.id_mapping_workflow_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"idMappingWorkflowProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.input_source_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"inputSourceConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIdNamespaceOutput {
    const result: UpdateIdNamespaceOutput = try aws.json.parseJsonObject(
        UpdateIdNamespaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
