/// Scte35 Splice Insert No Regional Blackout Behavior
pub const Scte35SpliceInsertNoRegionalBlackoutBehavior = enum {
    follow,
    ignore,

    pub const json_field_names = .{
        .follow = "FOLLOW",
        .ignore = "IGNORE",
    };
};
