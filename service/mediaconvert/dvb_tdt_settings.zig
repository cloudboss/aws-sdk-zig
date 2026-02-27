/// Use these settings to insert a DVB Time and Date Table (TDT) in the
/// transport stream of this output.
pub const DvbTdtSettings = struct {
    /// The number of milliseconds between instances of this table in the output
    /// transport stream.
    tdt_interval: ?i32,

    pub const json_field_names = .{
        .tdt_interval = "TdtInterval",
    };
};
