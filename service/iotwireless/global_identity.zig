/// Global identity information.
pub const GlobalIdentity = struct {
    /// GERAN (GSM EDGE Radio Access Network) cell global identifier.
    geran_cid: i32,

    /// Location area code of the global identity.
    lac: i32,

    pub const json_field_names = .{
        .geran_cid = "GeranCid",
        .lac = "Lac",
    };
};
