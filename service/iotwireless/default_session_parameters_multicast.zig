/// The default session parameters for the multicast group.
pub const DefaultSessionParametersMulticast = struct {
    dl_dr: ?i32 = null,

    dl_freq: ?i32 = null,

    pub const json_field_names = .{
        .dl_dr = "DlDr",
        .dl_freq = "DlFreq",
    };
};
