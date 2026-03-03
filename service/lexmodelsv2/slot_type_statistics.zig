/// The object that contains the statistical summary of the recommended
/// slot type associated with the bot recommendation.
pub const SlotTypeStatistics = struct {
    /// The number of recommended slot types associated with the bot
    /// recommendation.
    discovered_slot_type_count: ?i32 = null,

    pub const json_field_names = .{
        .discovered_slot_type_count = "discoveredSlotTypeCount",
    };
};
