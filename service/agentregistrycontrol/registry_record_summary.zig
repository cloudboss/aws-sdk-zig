const CustomMetadataSchemaComplianceStatus = @import("custom_metadata_schema_compliance_status.zig").CustomMetadataSchemaComplianceStatus;
const ProvenanceSummary = @import("provenance_summary.zig").ProvenanceSummary;
const RecordType = @import("record_type.zig").RecordType;
const RegistryRecordStatus = @import("registry_record_status.zig").RegistryRecordStatus;

/// A summary of a registry record returned by list operations. Contains
/// identifying and lifecycle fields but omits descriptor content.
pub const RegistryRecordSummary = struct {
    /// The timestamp when the registry record was created.
    created_at: i64,

    /// The ID of the Amazon Web Services account that created the registry record.
    created_by: ?[]const u8 = null,

    /// Specifies whether the registry record was created by auto-detection. `true`
    /// indicates the record was automatically created by the service based on the
    /// registry's auto-detection configuration; `false` indicates the record was
    /// created through a control-plane API call.
    created_by_auto_detection: ?bool = null,

    /// Indicates whether this record's custom metadata conforms to the registry's
    /// current schema.
    custom_metadata_schema_compliance_status: ?CustomMetadataSchemaComplianceStatus = null,

    /// A description of the registry record.
    description: ?[]const u8 = null,

    /// The human-readable display name of the registry record.
    display_name: ?[]const u8 = null,

    /// The name of the registry record. Names are unique within a registry.
    name: []const u8,

    /// The condensed provenance lineage for the registry record. Each entry
    /// contains the source relation, source identifier, and source type of an
    /// auto-detection lineage entry. Populated for records created by
    /// auto-detection.
    provenance_summary_list: ?[]const ProvenanceSummary = null,

    /// The Amazon Resource Name (ARN) of the registry record.
    record_arn: []const u8,

    /// The unique identifier of the registry record.
    record_id: []const u8,

    /// The type of the registry record, such as MCP, AGENT, SKILL, or CUSTOM.
    record_type: RecordType,

    /// The version identifier of the registry record.
    record_version: []const u8,

    /// The Amazon Resource Name (ARN) of the parent registry that owns the record.
    registry_arn: []const u8,

    /// The lifecycle status of the registry record.
    status: RegistryRecordStatus,

    /// The timestamp when the registry record was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .created_by_auto_detection = "createdByAutoDetection",
        .custom_metadata_schema_compliance_status = "customMetadataSchemaComplianceStatus",
        .description = "description",
        .display_name = "displayName",
        .name = "name",
        .provenance_summary_list = "provenanceSummaryList",
        .record_arn = "recordArn",
        .record_id = "recordId",
        .record_type = "recordType",
        .record_version = "recordVersion",
        .registry_arn = "registryArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
