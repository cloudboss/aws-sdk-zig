const IdMappingTableInputReferenceConfig = @import("id_mapping_table_input_reference_config.zig").IdMappingTableInputReferenceConfig;
const IdMappingTableInputReferenceProperties = @import("id_mapping_table_input_reference_properties.zig").IdMappingTableInputReferenceProperties;

/// Describes information about the ID mapping table.
pub const IdMappingTable = struct {
    /// The Amazon Resource Name (ARN) of the ID mapping table.
    arn: []const u8,

    /// The Amazon Resource Name (ARN) of the collaboration that contains this ID
    /// mapping table.
    collaboration_arn: []const u8,

    /// The unique identifier of the collaboration that contains this ID mapping
    /// table.
    collaboration_id: []const u8,

    /// The time at which the ID mapping table was created.
    create_time: i64,

    /// The description of the ID mapping table.
    description: ?[]const u8 = null,

    /// The unique identifier of the ID mapping table.
    id: []const u8,

    /// The input reference configuration for the ID mapping table.
    input_reference_config: IdMappingTableInputReferenceConfig,

    /// The input reference properties for the ID mapping table.
    input_reference_properties: IdMappingTableInputReferenceProperties,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services KMS key.
    kms_key_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the membership resource for the ID mapping
    /// table.
    membership_arn: []const u8,

    /// The unique identifier of the membership resource for the ID mapping table.
    membership_id: []const u8,

    /// The name of the ID mapping table.
    name: []const u8,

    /// The most recent time at which the ID mapping table was updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .description = "description",
        .id = "id",
        .input_reference_config = "inputReferenceConfig",
        .input_reference_properties = "inputReferenceProperties",
        .kms_key_arn = "kmsKeyArn",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .name = "name",
        .update_time = "updateTime",
    };
};
