/// DVB Time and Date Table (SDT)
pub const DvbTdtSettings = struct {
    /// The number of milliseconds between instances of this table in the output
    /// transport stream.
    rep_interval: ?i32,

    pub const json_field_names = .{
        .rep_interval = "RepInterval",
    };
};
