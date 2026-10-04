const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Descriptors = @import("descriptors.zig").Descriptors;
const DescriptorType = @import("descriptor_type.zig").DescriptorType;
const SynchronizationConfiguration = @import("synchronization_configuration.zig").SynchronizationConfiguration;
const SynchronizationType = @import("synchronization_type.zig").SynchronizationType;
const RegistryRecordStatus = @import("registry_record_status.zig").RegistryRecordStatus;

pub const CreateRegistryRecordInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// A description of the registry record.
    description: ?[]const u8 = null,

    /// The descriptor-type-specific configuration containing the resource schema
    /// and metadata. The structure of this field depends on the `descriptorType`
    /// you specify.
    descriptors: ?Descriptors = null,

    /// The descriptor type of the registry record.
    ///
    /// * `MCP` - Model Context Protocol descriptor for MCP-compatible servers and
    ///   tools.
    /// * `A2A` - Agent-to-Agent protocol descriptor.
    /// * `CUSTOM` - Custom descriptor type for resources such as APIs, Lambda
    ///   functions, or servers not conforming to a standard protocol.
    /// * `AGENT_SKILLS` - Agent skills descriptor for defining agent skill
    ///   definitions.
    descriptor_type: DescriptorType,

    /// The name of the registry record.
    name: []const u8,

    /// The version of the registry record. Use this to track different versions of
    /// the record's content.
    record_version: ?[]const u8 = null,

    /// The identifier of the registry where the record will be created. You can
    /// specify either the Amazon Resource Name (ARN) or the ID of the registry.
    registry_id: []const u8,

    /// The configuration for synchronizing registry record metadata from an
    /// external source, such as a URL-based MCP server.
    synchronization_configuration: ?SynchronizationConfiguration = null,

    /// The type of synchronization to use for keeping the record metadata up to
    /// date from an external source. Possible values include `FROM_URL` and `NONE`.
    synchronization_type: ?SynchronizationType = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .descriptors = "descriptors",
        .descriptor_type = "descriptorType",
        .name = "name",
        .record_version = "recordVersion",
        .registry_id = "registryId",
        .synchronization_configuration = "synchronizationConfiguration",
        .synchronization_type = "synchronizationType",
    };
};

pub const CreateRegistryRecordOutput = struct {
    /// The Amazon Resource Name (ARN) of the created registry record.
    record_arn: []const u8,

    /// The status of the registry record. Set to `CREATING` while the asynchronous
    /// workflow is in progress.
    status: RegistryRecordStatus,

    pub const json_field_names = .{
        .record_arn = "recordArn",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRegistryRecordInput, options: CallOptions) !CreateRegistryRecordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRegistryRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/registries/");
    try path_buf.appendSlice(allocator, input.registry_id);
    try path_buf.appendSlice(allocator, "/records");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.descriptors) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"descriptors\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"descriptorType\":");
    try aws.json.writeValue(@TypeOf(input.descriptor_type), input.descriptor_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.record_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"recordVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.synchronization_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"synchronizationConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.synchronization_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"synchronizationType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRegistryRecordOutput {
    const result: CreateRegistryRecordOutput = try aws.json.parseJsonObject(
        CreateRegistryRecordOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
