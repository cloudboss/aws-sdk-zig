pub const RemediationTargetType = enum {
    ssm_document,

    pub const json_field_names = .{
        .ssm_document = "SSM_DOCUMENT",
    };
};
