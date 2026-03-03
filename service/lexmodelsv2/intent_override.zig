const aws = @import("aws");

const SlotValueOverride = @import("slot_value_override.zig").SlotValueOverride;

/// Override settings to configure the intent state.
pub const IntentOverride = struct {
    /// The name of the intent. Only required when you're switching
    /// intents.
    name: ?[]const u8 = null,

    /// A map of all of the slot value overrides for the intent. The name of
    /// the slot maps to the value of the slot. Slots that are not included in
    /// the map aren't overridden.
    slots: ?[]const aws.map.MapEntry(SlotValueOverride) = null,

    pub const json_field_names = .{
        .name = "name",
        .slots = "slots",
    };
};
