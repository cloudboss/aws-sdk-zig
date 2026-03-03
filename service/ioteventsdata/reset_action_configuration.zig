/// Contains the configuration information of a reset action.
pub const ResetActionConfiguration = struct {
    /// The note that you can leave when you reset the alarm.
    note: ?[]const u8 = null,

    pub const json_field_names = .{
        .note = "note",
    };
};
