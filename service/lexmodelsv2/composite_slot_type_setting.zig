const SubSlotTypeComposition = @import("sub_slot_type_composition.zig").SubSlotTypeComposition;

/// A composite slot is a combination of two or more slots
/// that capture multiple pieces of information in a single user input.
pub const CompositeSlotTypeSetting = struct {
    /// Subslots in the composite slot.
    sub_slots: ?[]const SubSlotTypeComposition = null,

    pub const json_field_names = .{
        .sub_slots = "subSlots",
    };
};
