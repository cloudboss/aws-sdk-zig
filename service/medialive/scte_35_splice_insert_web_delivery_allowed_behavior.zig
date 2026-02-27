/// Scte35 Splice Insert Web Delivery Allowed Behavior
pub const Scte35SpliceInsertWebDeliveryAllowedBehavior = enum {
    follow,
    ignore,

    pub const json_field_names = .{
        .follow = "FOLLOW",
        .ignore = "IGNORE",
    };
};
