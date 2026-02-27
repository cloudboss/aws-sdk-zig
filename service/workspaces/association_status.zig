pub const AssociationStatus = enum {
    not_associated,
    associated_with_owner_account,
    associated_with_shared_account,
    pending_association,
    pending_disassociation,

    pub const json_field_names = .{
        .not_associated = "NOT_ASSOCIATED",
        .associated_with_owner_account = "ASSOCIATED_WITH_OWNER_ACCOUNT",
        .associated_with_shared_account = "ASSOCIATED_WITH_SHARED_ACCOUNT",
        .pending_association = "PENDING_ASSOCIATION",
        .pending_disassociation = "PENDING_DISASSOCIATION",
    };
};
