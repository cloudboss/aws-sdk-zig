pub const TrustDirection = enum {
    one_way_outgoing,
    one_way_incoming,
    two_way,

    pub const json_field_names = .{
        .one_way_outgoing = "ONE_WAY_OUTGOING",
        .one_way_incoming = "ONE_WAY_INCOMING",
        .two_way = "TWO_WAY",
    };
};
