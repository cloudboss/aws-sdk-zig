const SubSlotValueElicitationSetting = @import("sub_slot_value_elicitation_setting.zig").SubSlotValueElicitationSetting;

/// Subslot specifications.
pub const Specifications = struct {
    /// The unique identifier assigned to the slot type.
    slot_type_id: []const u8,

    /// Specifies the elicitation setting details for constituent sub slots of a
    /// composite slot.
    value_elicitation_setting: SubSlotValueElicitationSetting,

    pub const json_field_names = .{
        .slot_type_id = "slotTypeId",
        .value_elicitation_setting = "valueElicitationSetting",
    };
};
