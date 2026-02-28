const JoinKeyProperties = @import("join_key_properties.zig").JoinKeyProperties;
const JoinType = @import("join_type.zig").JoinType;

/// The instructions associated with a join.
pub const JoinInstruction = struct {
    /// Join key properties of the left operand.
    left_join_key_properties: ?JoinKeyProperties,

    /// The operand on the left side of a join.
    left_operand: []const u8,

    /// The join instructions provided in the `ON` clause of a join.
    on_clause: []const u8,

    /// Join key properties of the right operand.
    right_join_key_properties: ?JoinKeyProperties,

    /// The operand on the right side of a join.
    right_operand: []const u8,

    /// The type of join that it is.
    @"type": JoinType,

    pub const json_field_names = .{
        .left_join_key_properties = "LeftJoinKeyProperties",
        .left_operand = "LeftOperand",
        .on_clause = "OnClause",
        .right_join_key_properties = "RightJoinKeyProperties",
        .right_operand = "RightOperand",
        .@"type" = "Type",
    };
};
