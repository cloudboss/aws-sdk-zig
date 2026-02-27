/// Subslot type composition.
pub const SubSlotTypeComposition = struct {
    /// Name of a constituent sub slot inside a composite slot.
    name: []const u8,

    /// The unique identifier assigned to a slot type.
    /// This refers to either a built-in slot type or the unique slotTypeId of a
    /// custom slot type.
    slot_type_id: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .slot_type_id = "slotTypeId",
    };
};
