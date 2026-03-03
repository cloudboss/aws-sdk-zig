/// Contains the configuration information of a disable action.
pub const DisableActionConfiguration = struct {
    /// The note that you can leave when you disable the alarm.
    note: ?[]const u8 = null,

    pub const json_field_names = .{
        .note = "note",
    };
};
