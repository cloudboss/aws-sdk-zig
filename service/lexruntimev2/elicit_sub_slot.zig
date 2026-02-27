/// The specific constituent sub slot of the composite slot to elicit in dialog
/// action.
pub const ElicitSubSlot = struct {
    /// The name of the slot that should be elicited from the user.
    name: []const u8,

    /// The field is not supported.
    sub_slot_to_elicit: ?*ElicitSubSlot = null,

    pub const json_field_names = .{
        .name = "name",
        .sub_slot_to_elicit = "subSlotToElicit",
    };
};
