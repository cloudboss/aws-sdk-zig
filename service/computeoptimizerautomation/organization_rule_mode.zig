pub const OrganizationRuleMode = enum {
    any_allowed,
    none_allowed,

    pub const json_field_names = .{
        .any_allowed = "ANY_ALLOWED",
        .none_allowed = "NONE_ALLOWED",
    };
};
