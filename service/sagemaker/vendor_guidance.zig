pub const VendorGuidance = enum {
    not_provided,
    stable,
    to_be_archived,
    archived,

    pub const json_field_names = .{
        .not_provided = "NOT_PROVIDED",
        .stable = "STABLE",
        .to_be_archived = "TO_BE_ARCHIVED",
        .archived = "ARCHIVED",
    };
};
