const RecordType = @import("record_type.zig").RecordType;
const RegistryRecordStatus = @import("registry_record_status.zig").RegistryRecordStatus;

/// Summary information about a discoverable registry record returned by `
/// ListDiscoverableRegistryRecords`. This summary does not include descriptors.
pub const DiscoverableRegistryRecordSummary = struct {
    /// The timestamp when the registry record was created.
    created_at: i64,

    /// A human-readable description of the registry record. Use this field to
    /// explain the record's purpose or content to consumers discovering it in the
    /// registry.
    description: ?[]const u8 = null,

    /// The descriptor types that are present on this registry record. Each value
    /// corresponds to a descriptor entry key on the approved record.
    descriptor_types: ?[]const []const u8 = null,

    /// The human-readable display name of the registry record.
    display_name: ?[]const u8 = null,

    /// The name of the registry record. Names are unique within a registry.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the registry record.
    record_arn: []const u8,

    /// The unique identifier of the registry record.
    record_id: []const u8,

    /// The type of the registry record. `MCP` is a Model Context Protocol server
    /// record, `AGENT` is an Agent-to-Agent (A2A) agent card record, `SKILL` is an
    /// agent skills definition record, and `CUSTOM` is a record with a custom
    /// descriptor.
    record_type: RecordType,

    /// The version identifier of the registry record.
    record_version: []const u8,

    /// The Amazon Resource Name (ARN) of the parent registry that owns the record.
    registry_arn: []const u8,

    /// The lifecycle status of the registry record. A record is `DRAFT` before it
    /// is submitted, `PENDING_APPROVAL` while awaiting curator review, and
    /// `APPROVED` once it is approved and discoverable. `REJECTED` and `DEPRECATED`
    /// records are not discoverable. The `CREATING`, `UPDATING`, `CREATE_FAILED`,
    /// and `UPDATE_FAILED` values reflect the state of an in-progress or failed
    /// asynchronous change.
    status: RegistryRecordStatus,

    /// The timestamp when the registry record was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .descriptor_types = "descriptorTypes",
        .display_name = "displayName",
        .name = "name",
        .record_arn = "recordArn",
        .record_id = "recordId",
        .record_type = "recordType",
        .record_version = "recordVersion",
        .registry_arn = "registryArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
