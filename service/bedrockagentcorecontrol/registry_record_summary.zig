const DescriptorType = @import("descriptor_type.zig").DescriptorType;
const RegistryRecordStatus = @import("registry_record_status.zig").RegistryRecordStatus;

/// Contains summary information about a registry record.
pub const RegistryRecordSummary = struct {
    /// The timestamp when the registry record was created.
    created_at: i64,

    /// The description of the registry record.
    description: ?[]const u8 = null,

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
    record_version: []const u8,

    /// The Amazon Resource Name (ARN) of the registry that contains the record.
    registry_arn: []const u8,

    /// The current status of the registry record. Possible values include
    /// `CREATING`, `DRAFT`, `APPROVED`, `PENDING_APPROVAL`, `REJECTED`,
    /// `DEPRECATED`, `UPDATING`, `CREATE_FAILED`, and `UPDATE_FAILED`.
    status: RegistryRecordStatus,

    /// The timestamp when the registry record was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .descriptor_type = "descriptorType",
        .name = "name",
        .record_arn = "recordArn",
        .record_id = "recordId",
        .record_version = "recordVersion",
        .registry_arn = "registryArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
