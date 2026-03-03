/// Provides information about a slot used in a built-in
/// intent.
pub const BuiltinIntentSlot = struct {
    /// A list of the slots defined for the intent.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
    };
};
