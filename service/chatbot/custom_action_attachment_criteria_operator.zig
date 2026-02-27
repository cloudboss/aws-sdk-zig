pub const CustomActionAttachmentCriteriaOperator = enum {
    has_value,
    equals,

    pub const json_field_names = .{
        .has_value = "HAS_VALUE",
        .equals = "EQUALS",
    };
};
