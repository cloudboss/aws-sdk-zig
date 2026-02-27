pub const MembershipAccountRelationshipStatus = enum {
    associated,
    disassociated,
    unassociated,

    pub const json_field_names = .{
        .associated = "ASSOCIATED",
        .disassociated = "DISASSOCIATED",
        .unassociated = "UNASSOCIATED",
    };
};
