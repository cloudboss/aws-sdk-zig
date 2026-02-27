pub const MembershipAccountRelationshipType = enum {
    organization,
    unrelated,

    pub const json_field_names = .{
        .organization = "ORGANIZATION",
        .unrelated = "UNRELATED",
    };
};
