/// The definition for the slot.
pub const Slot = struct {
    /// The slot ID of the slot.
    slot_id: ?[]const u8 = null,

    /// The visual ID for the slot.
    visual_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .slot_id = "SlotId",
        .visual_id = "VisualId",
    };
};
