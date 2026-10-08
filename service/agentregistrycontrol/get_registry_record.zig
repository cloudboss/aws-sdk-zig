const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomMetadataSchemaComplianceStatus = @import("custom_metadata_schema_compliance_status.zig").CustomMetadataSchemaComplianceStatus;
const Descriptors = @import("descriptors.zig").Descriptors;
const Provenance = @import("provenance.zig").Provenance;
const RecordType = @import("record_type.zig").RecordType;
const RegistryRecordStatus = @import("registry_record_status.zig").RegistryRecordStatus;

pub const GetRegistryRecordInput = struct {
    /// The identifier of the registry record to retrieve (ARN or ID)
    record_id: []const u8,

    /// The identifier of the registry containing the record (ARN or ID)
    registry_id: []const u8,

    pub const json_field_names = .{
        .record_id = "recordId",
        .registry_id = "registryId",
    };
};

pub const GetRegistryRecordOutput = struct {
    /// The timestamp when the registry record was created.
    created_at: i64,

    /// The ID of the Amazon Web Services account that created the registry record.
    created_by: ?[]const u8 = null,

    /// Specifies whether the registry record was created by auto-detection. `true`
    /// indicates the record was automatically created by the service based on the
    /// registry's auto-detection configuration; `false` indicates the record was
    /// created through a control-plane API call.
    created_by_auto_detection: ?bool = null,

    /// The custom metadata attached to this registry record. Values are strings
    /// (maximum 128 characters) or booleans.
    custom_metadata: ?[]const u8 = null,

    /// Indicates whether this record's custom metadata conforms to the registry's
    /// current schema. This status is computed at read time against the latest
    /// schema.
    custom_metadata_schema_compliance_status: ?CustomMetadataSchemaComplianceStatus = null,

    /// A description of the registry record.
    description: ?[]const u8 = null,

    /// The typed descriptors that define the content of the registry record.
    descriptors: ?Descriptors = null,

    /// The human-readable display name of the registry record.
    display_name: ?[]const u8 = null,

    /// The name of the registry record. Names are unique within a registry.
    name: []const u8,

    /// The provenance lineage entries for the registry record. Populated for
    /// records created by auto-detection; each entry identifies the upstream source
    /// that the record was detected from.
    provenance: ?[]const Provenance = null,

    /// The Amazon Resource Name (ARN) of the registry record.
    record_arn: []const u8,

    /// The unique identifier of the registry record.
    record_id: []const u8,

    /// The type of the registry record, such as MCP, AGENT, SKILL, or CUSTOM.
    record_type: RecordType,

    /// The version identifier of the registry record.
    record_version: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the parent registry that owns the record.
    registry_arn: []const u8,

    /// The lifecycle status of the registry record.
    status: RegistryRecordStatus,

    /// The reason for the current status. Typically populated when the status
    /// indicates a failure state.
    status_reason: ?[]const u8 = null,

    /// The timestamp when the registry record was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .created_by_auto_detection = "createdByAutoDetection",
        .custom_metadata = "customMetadata",
        .custom_metadata_schema_compliance_status = "customMetadataSchemaComplianceStatus",
        .description = "description",
        .descriptors = "descriptors",
        .display_name = "displayName",
        .name = "name",
        .provenance = "provenance",
        .record_arn = "recordArn",
        .record_id = "recordId",
        .record_type = "recordType",
        .record_version = "recordVersion",
        .registry_arn = "registryArn",
        .status = "status",
        .status_reason = "statusReason",
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
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "agent-registry", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("agent-registry-control", "Agent Registry Control", allocator);

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
    const result: GetRegistryRecordOutput = try aws.json.parseJsonObject(
        GetRegistryRecordOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
