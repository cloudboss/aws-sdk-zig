pub const AssociationEdgeType = enum {
    contributed_to,
    associated_with,
    derived_from,
    produced,
    same_as,

    pub const json_field_names = .{
        .contributed_to = "CONTRIBUTED_TO",
        .associated_with = "ASSOCIATED_WITH",
        .derived_from = "DERIVED_FROM",
        .produced = "PRODUCED",
        .same_as = "SAME_AS",
    };
};
