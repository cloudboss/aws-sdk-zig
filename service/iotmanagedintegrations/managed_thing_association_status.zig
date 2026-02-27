pub const ManagedThingAssociationStatus = enum {
    pre_associated,
    associated,

    pub const json_field_names = .{
        .pre_associated = "PRE_ASSOCIATED",
        .associated = "ASSOCIATED",
    };
};
