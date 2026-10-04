const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IncludedData = @import("included_data.zig").IncludedData;
const FlowDefinition = @import("flow_definition.zig").FlowDefinition;
const FlowStatus = @import("flow_status.zig").FlowStatus;

pub const GetFlowVersionInput = struct {
    /// The unique identifier of the flow for which to get information.
    flow_identifier: []const u8,

    /// The version of the flow for which to get information.
    flow_version: []const u8,

    /// Controls the scope of data returned. Set to `METADATA_ONLY` to return only
    /// resource metadata. Set to `ALL_DATA` or omit this field to return the full
    /// response.
    included_data: ?IncludedData = null,

    pub const json_field_names = .{
        .flow_identifier = "flowIdentifier",
        .flow_version = "flowVersion",
        .included_data = "includedData",
    };
};

pub const GetFlowVersionOutput = struct {
    /// The Amazon Resource Name (ARN) of the flow.
    arn: []const u8,

    /// The time at which the flow was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the KMS key that the version of the flow
    /// is encrypted with.
    customer_encryption_key_arn: ?[]const u8 = null,

    /// The definition of the nodes and connections between nodes in the flow.
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

    /// The name of the version.
    name: []const u8,

    /// The status of the flow.
    status: FlowStatus,

    /// The version of the flow for which information was retrieved.
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
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFlowVersionInput, options: CallOptions) !GetFlowVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFlowVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/flows/");
    try path_buf.appendSlice(allocator, input.flow_identifier);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.flow_version);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.included_data) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "includedData=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFlowVersionOutput {
    const result: GetFlowVersionOutput = try aws.json.parseJsonObject(
        GetFlowVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
