pub const InternalAccessType = enum {
    intra_account,
    intra_org,

    pub const json_field_names = .{
        .intra_account = "INTRA_ACCOUNT",
        .intra_org = "INTRA_ORG",
    };
};
