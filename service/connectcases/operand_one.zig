/// Represents the left hand operand in the condition. In the Amazon Connect
/// admin website, case rules are known as *case field conditions*. For more
/// information about case field conditions, see [Add case field conditions to a
/// case
/// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
pub const OperandOne = union(enum) {
    /// The field ID that this operand should take the value of.
    field_id: ?[]const u8,

    pub const json_field_names = .{
        .field_id = "fieldId",
    };
};
