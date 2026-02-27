/// Scte35 Apos Web Delivery Allowed Behavior
pub const Scte35AposWebDeliveryAllowedBehavior = enum {
    follow,
    ignore,

    pub const json_field_names = .{
        .follow = "FOLLOW",
        .ignore = "IGNORE",
    };
};
