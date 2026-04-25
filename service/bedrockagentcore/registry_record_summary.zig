const Descriptors = @import("descriptors.zig").Descriptors;
const DescriptorType = @import("descriptor_type.zig").DescriptorType;
const RegistryRecordStatus = @import("registry_record_status.zig").RegistryRecordStatus;

/// Summary information about a registry record.
pub const RegistryRecordSummary = struct {
    /// The date and time when the registry record was created.
    created_at: i64,

    /// A description of the registry record.
    description: ?[]const u8 = null,

    /// The descriptor configurations for this registry record.
    descriptors: Descriptors,

    /// The type of descriptor associated with this registry record.
    descriptor_type: DescriptorType,

    /// The name of the registry record.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the registry record.
    record_arn: []const u8,

    /// The unique identifier of the registry record.
    record_id: []const u8,

    /// The Amazon Resource Name (ARN) of the registry that this record belongs to.
    registry_arn: []const u8,

    /// The current status of the registry record.
    status: RegistryRecordStatus,

    /// The date and time when the registry record was last updated.
    updated_at: i64,

    /// The version of the registry record.
    version: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .descriptors = "descriptors",
        .descriptor_type = "descriptorType",
        .name = "name",
        .record_arn = "recordArn",
        .record_id = "recordId",
        .registry_arn = "registryArn",
        .status = "status",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
