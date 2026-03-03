const JoinInstruction = @import("join_instruction.zig").JoinInstruction;

/// Information about the source of a logical table. This is a variant type
/// structure. For
/// this structure to be valid, only one of the attributes can be non-null.
pub const LogicalTableSource = struct {
    /// The Amazon Resource Number (ARN) of the parent dataset.
    data_set_arn: ?[]const u8 = null,

    /// Specifies the result of a join of two logical tables.
    join_instruction: ?JoinInstruction = null,

    /// Physical table ID.
    physical_table_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_set_arn = "DataSetArn",
        .join_instruction = "JoinInstruction",
        .physical_table_id = "PhysicalTableId",
    };
};
