const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdatedCustomMetadataMap = @import("updated_custom_metadata_map.zig").UpdatedCustomMetadataMap;
const UpdatedDescription = @import("updated_description.zig").UpdatedDescription;
const UpdatedDescriptors = @import("updated_descriptors.zig").UpdatedDescriptors;
const UpdatedDisplayName = @import("updated_display_name.zig").UpdatedDisplayName;
const Provenance = @import("provenance.zig").Provenance;
const RecordType = @import("record_type.zig").RecordType;
const CustomMetadataSchemaComplianceStatus = @import("custom_metadata_schema_compliance_status.zig").CustomMetadataSchemaComplianceStatus;
const Descriptors = @import("descriptors.zig").Descriptors;
const RegistryRecordStatus = @import("registry_record_status.zig").RegistryRecordStatus;

pub const UpdateRegistryRecordInput = struct {
    /// The updated custom metadata for the registry record. Values can be strings
    /// (maximum 128 characters) or native JSON booleans (`true` or `false`). Omit
    /// to leave the existing metadata unchanged. Supply the wrapper with a full
    /// replacement set to update, or with a null value to clear all metadata.
    custom_metadata: ?UpdatedCustomMetadataMap = null,

    /// The updated description of the registry record. Omit to leave the
    /// description unchanged; provide an empty wrapper to unset it.
    description: ?UpdatedDescription = null,

    /// The updated typed descriptor content for the registry record. Omit to leave
    /// the descriptors unchanged.
    descriptors: ?UpdatedDescriptors = null,

    /// The updated display name of the registry record. Omit to leave the display
    /// name unchanged; provide an empty wrapper to unset it.
    display_name: ?UpdatedDisplayName = null,

    /// The updated name of the registry record. Omit to leave the name unchanged.
    name: ?[]const u8 = null,

    /// The provenance lineage re-assertion for the registry record. This field is
    /// reserved for the Amazon Web Services Agent Registry auto-detection service
    /// principal. Requests that include this field from other callers are rejected.
    /// The source identity of an existing lineage is immutable; a re-assertion may
    /// only refresh the source details.
    provenance: ?[]const Provenance = null,

    /// The identifier of the registry record to update (ARN or ID)
    record_id: []const u8,

    /// The updated type of the registry record. Omit to leave the record type
    /// unchanged.
    record_type: ?RecordType = null,

    /// The updated version of the registry record. Omit to leave the version
    /// unchanged.
    record_version: ?[]const u8 = null,

    /// The identifier of the registry containing the record (ARN or ID)
    registry_id: []const u8,

    /// Whether to trigger synchronization of the record's descriptor content from
    /// its source
    trigger_synchronization: ?bool = null,

    pub const json_field_names = .{
        .custom_metadata = "customMetadata",
        .description = "description",
        .descriptors = "descriptors",
        .display_name = "displayName",
        .name = "name",
        .provenance = "provenance",
        .record_id = "recordId",
        .record_type = "recordType",
        .record_version = "recordVersion",
        .registry_id = "registryId",
        .trigger_synchronization = "triggerSynchronization",
    };
};

pub const UpdateRegistryRecordOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRegistryRecordInput, options: CallOptions) !UpdateRegistryRecordOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRegistryRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("agent-registry-control", "Agent Registry Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/registries/");
    try path_buf.appendSlice(allocator, input.registry_id);
    try path_buf.appendSlice(allocator, "/records/");
    try path_buf.appendSlice(allocator, input.record_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.custom_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customMetadata\":");
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
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.provenance) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"provenance\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.record_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"recordType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.record_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"recordVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.trigger_synchronization) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"triggerSynchronization\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRegistryRecordOutput {
    const result: UpdateRegistryRecordOutput = try aws.json.parseJsonObject(
        UpdateRegistryRecordOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
