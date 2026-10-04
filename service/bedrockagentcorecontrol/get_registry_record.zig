const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Descriptors = @import("descriptors.zig").Descriptors;
const DescriptorType = @import("descriptor_type.zig").DescriptorType;
const RegistryRecordStatus = @import("registry_record_status.zig").RegistryRecordStatus;
const SynchronizationConfiguration = @import("synchronization_configuration.zig").SynchronizationConfiguration;
const SynchronizationType = @import("synchronization_type.zig").SynchronizationType;

pub const GetRegistryRecordInput = struct {
    /// The identifier of the registry record to retrieve. You can specify either
    /// the Amazon Resource Name (ARN) or the ID of the record.
    record_id: []const u8,

    /// The identifier of the registry containing the record. You can specify either
    /// the Amazon Resource Name (ARN) or the ID of the registry.
    registry_id: []const u8,

    pub const json_field_names = .{
        .record_id = "recordId",
        .registry_id = "registryId",
    };
};

pub const GetRegistryRecordOutput = struct {
    /// The timestamp when the registry record was created.
    created_at: i64,

    /// The description of the registry record.
    description: ?[]const u8 = null,

    /// The descriptor-type-specific configuration containing the resource schema
    /// and metadata. For details, see the `Descriptors` data type.
    descriptors: ?Descriptors = null,

    /// The descriptor type of the registry record. Possible values are `MCP`,
    /// `A2A`, `CUSTOM`, and `AGENT_SKILLS`.
    descriptor_type: DescriptorType,

    /// The name of the registry record.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the registry record.
    record_arn: []const u8,

    /// The unique identifier of the registry record.
    record_id: []const u8,

    /// The version of the registry record.
    record_version: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the registry that contains the record.
    registry_arn: []const u8,

    /// The current status of the registry record. Possible values include
    /// `CREATING`, `DRAFT`, `APPROVED`, `PENDING_APPROVAL`, `REJECTED`,
    /// `DEPRECATED`, `UPDATING`, `CREATE_FAILED`, and `UPDATE_FAILED`. A record
    /// transitions from `CREATING` to `DRAFT`, then to `PENDING_APPROVAL` (via
    /// `SubmitRegistryRecordForApproval`), and finally to `APPROVED` upon approval.
    status: RegistryRecordStatus,

    /// The reason for the current status, typically set when the status is a
    /// failure state.
    status_reason: ?[]const u8 = null,

    /// The configuration for synchronizing registry record metadata from an
    /// external source.
    synchronization_configuration: ?SynchronizationConfiguration = null,

    /// The type of synchronization used for this record.
    synchronization_type: ?SynchronizationType = null,

    /// The timestamp when the registry record was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .descriptors = "descriptors",
        .descriptor_type = "descriptorType",
        .name = "name",
        .record_arn = "recordArn",
        .record_id = "recordId",
        .record_version = "recordVersion",
        .registry_arn = "registryArn",
        .status = "status",
        .status_reason = "statusReason",
        .synchronization_configuration = "synchronizationConfiguration",
        .synchronization_type = "synchronizationType",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRegistryRecordInput, options: CallOptions) !GetRegistryRecordOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRegistryRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/registries/");
    try path_buf.appendSlice(allocator, input.registry_id);
    try path_buf.appendSlice(allocator, "/records/");
    try path_buf.appendSlice(allocator, input.record_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRegistryRecordOutput {
    var result: GetRegistryRecordOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRegistryRecordOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
