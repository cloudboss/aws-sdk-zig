/// A reason that a signal isn't valid.
pub const InvalidSignal = struct {
    /// The name of the signal that isn't valid.
    name: ?[]const u8,

    /// A message about why the signal isn't valid.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .reason = "reason",
    };
};
