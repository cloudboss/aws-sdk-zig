/// Contains the configuration information of an acknowledge action.
pub const AcknowledgeActionConfiguration = struct {
    /// The note that you can leave when you acknowledge the alarm.
    note: ?[]const u8,

    pub const json_field_names = .{
        .note = "note",
    };
};
