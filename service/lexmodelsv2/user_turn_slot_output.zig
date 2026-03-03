const aws = @import("aws");

/// Contains information about a slot output by the test set execution.
pub const UserTurnSlotOutput = struct {
    /// A list of items mapping the name of the subslots to information about those
    /// subslots.
    sub_slots: ?[]const aws.map.MapEntry(UserTurnSlotOutput) = null,

    /// The value output by the slot recognition.
    value: ?[]const u8 = null,

    /// Values that are output by the slot recognition.
    values: ?[]const UserTurnSlotOutput = null,

    pub const json_field_names = .{
        .sub_slots = "subSlots",
        .value = "value",
        .values = "values",
    };
};
