const IdMappingTableInputReferenceConfig = @import("id_mapping_table_input_reference_config.zig").IdMappingTableInputReferenceConfig;

/// Detailed information about the ID mapping table.
pub const IdMappingTableSummary = struct {
    /// The Amazon Resource Name (ARN) of this ID mapping table.
    arn: []const u8,

    /// The Amazon Resource Name (ARN) of the collaboration that contains this ID
    /// mapping table.
    collaboration_arn: []const u8,

    /// The unique identifier of the collaboration that contains this ID mapping
    /// table.
    collaboration_id: []const u8,

    /// The time at which this ID mapping table was created.
    create_time: i64,

    /// The description of this ID mapping table.
    description: ?[]const u8 = null,

    /// The unique identifier of this ID mapping table.
    id: []const u8,

    /// The input reference configuration for the ID mapping table.
    input_reference_config: IdMappingTableInputReferenceConfig,

    /// The Amazon Resource Name (ARN) of the membership resource for this ID
    /// mapping table.
    membership_arn: []const u8,

    /// The unique identifier of the membership resource for this ID mapping table.
    membership_id: []const u8,

    /// The name of this ID mapping table.
    name: []const u8,

    /// The most recent time at which this ID mapping table was updated.
    update_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .collaboration_arn = "collaborationArn",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .description = "description",
        .id = "id",
        .input_reference_config = "inputReferenceConfig",
        .membership_arn = "membershipArn",
        .membership_id = "membershipId",
        .name = "name",
        .update_time = "updateTime",
    };
};
