pub const SupportedAwsIntegration = enum {
    kms_tde,

    pub const json_field_names = .{
        .kms_tde = "KmsTde",
    };
};
