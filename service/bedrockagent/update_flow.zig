const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FlowDefinition = @import("flow_definition.zig").FlowDefinition;
const FlowStatus = @import("flow_status.zig").FlowStatus;

pub const UpdateFlowInput = struct {
    /// The Amazon Resource Name (ARN) of the KMS key to encrypt the flow.
    customer_encryption_key_arn: ?[]const u8 = null,

    /// A definition of the nodes and the connections between the nodes in the flow.
    definition: ?FlowDefinition = null,

    /// A description for the flow.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service role with permissions to
    /// create and manage a flow. For more information, see [Create a service role
    /// for flows in Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-permissions.html) in the Amazon Bedrock User Guide.
    execution_role_arn: []const u8,

    /// The unique identifier of the flow.
    flow_identifier: []const u8,

    /// A name for the flow.
    name: []const u8,

    pub const json_field_names = .{
        .customer_encryption_key_arn = "customerEncryptionKeyArn",
        .definition = "definition",
        .description = "description",
        .execution_role_arn = "executionRoleArn",
        .flow_identifier = "flowIdentifier",
        .name = "name",
    };
};

pub const UpdateFlowOutput = struct {
    /// The Amazon Resource Name (ARN) of the flow.
    arn: []const u8,

    /// The time at which the flow was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the KMS key that the flow was encrypted
    /// with.
    customer_encryption_key_arn: ?[]const u8 = null,

    /// A definition of the nodes and the connections between nodes in the flow.
    definition: ?FlowDefinition = null,

    /// The description of the flow.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the service role with permissions to
    /// create a flow. For more information, see [Create a service role for flows in
    /// Amazon
    /// Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-permissions.html) in the Amazon Bedrock User Guide.
    execution_role_arn: []const u8,

    /// The unique identifier of the flow.
    id: []const u8,

    /// The name of the flow.
    name: []const u8,

    /// The status of the flow. When you submit this request, the status will be
    /// `NotPrepared`. If updating fails, the status becomes `Failed`.
    status: FlowStatus,

    /// The time at which the flow was last updated.
    updated_at: i64,

    /// The version of the flow. When you update a flow, the version updated is the
    /// `DRAFT` version.
    version: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .customer_encryption_key_arn = "customerEncryptionKeyArn",
        .definition = "definition",
        .description = "description",
        .execution_role_arn = "executionRoleArn",
        .id = "id",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFlowInput, options: CallOptions) !UpdateFlowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/flows/");
    try path_buf.appendSlice(allocator, input.flow_identifier);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.customer_encryption_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customerEncryptionKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.definition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"definition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"executionRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.execution_role_arn), input.execution_role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFlowOutput {
    const result: UpdateFlowOutput = try aws.json.parseJsonObject(
        UpdateFlowOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
