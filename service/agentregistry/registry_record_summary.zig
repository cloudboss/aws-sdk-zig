const Descriptors = @import("descriptors.zig").Descriptors;
const RecordType = @import("record_type.zig").RecordType;
const RegistryRecordStatus = @import("registry_record_status.zig").RegistryRecordStatus;

/// Summary information about a registry record, including its descriptors.
pub const RegistryRecordSummary = struct {
    /// The timestamp when the registry record was created.
    created_at: i64,

    /// The custom metadata attached to this registry record. Values are strings
    /// (maximum 128 characters) or booleans. This field is only present if the
    /// registry has a custom metadata schema configured.
    custom_metadata: ?[]const u8 = null,

    /// A human-readable description of the registry record. Use this field to
    /// explain the record's purpose or content to consumers discovering it in the
    /// registry.
    description: ?[]const u8 = null,

    /// The protocol-specific descriptors that describe how to connect to and use
    /// the record.
    descriptors: Descriptors,

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
        .custom_metadata = "customMetadata",
        .description = "description",
        .descriptors = "descriptors",
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
