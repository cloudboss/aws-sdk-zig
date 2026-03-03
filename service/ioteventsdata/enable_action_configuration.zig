/// Contains the configuration information of an enable action.
pub const EnableActionConfiguration = struct {
    /// The note that you can leave when you enable the alarm.
    note: ?[]const u8 = null,

    pub const json_field_names = .{
        .note = "note",
    };
};
