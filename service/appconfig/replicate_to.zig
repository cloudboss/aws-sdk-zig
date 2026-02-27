pub const ReplicateTo = enum {
    none,
    ssm_document,

    pub const json_field_names = .{
        .none = "NONE",
        .ssm_document = "SSM_DOCUMENT",
    };
};
