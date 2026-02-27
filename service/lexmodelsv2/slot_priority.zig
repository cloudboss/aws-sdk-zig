/// Sets the priority that Amazon Lex should use when eliciting slot values
/// from a user.
pub const SlotPriority = struct {
    /// The priority that Amazon Lex should apply to the slot.
    priority: i32,

    /// The unique identifier of the slot.
    slot_id: []const u8,

    pub const json_field_names = .{
        .priority = "priority",
        .slot_id = "slotId",
    };
};
