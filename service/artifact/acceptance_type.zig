pub const AcceptanceType = enum {
    /// Do not require explicit click-through acceptance
    /// of the Term associated with this Report
    passthrough,
    /// Require explicit click-through acceptance of the
    /// Term associated with this Report.
    explicit,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .explicit = "EXPLICIT",
    };
};
