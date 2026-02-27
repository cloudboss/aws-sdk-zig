/// Scte35 Apos No Regional Blackout Behavior
pub const Scte35AposNoRegionalBlackoutBehavior = enum {
    follow,
    ignore,

    pub const json_field_names = .{
        .follow = "FOLLOW",
        .ignore = "IGNORE",
    };
};
