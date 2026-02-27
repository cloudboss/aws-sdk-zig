pub const SecurityConfigType = enum {
    /// saml provider
    saml,
    /// iam identity center
    iamidentitycenter,
    /// iam federation
    iamfederation,

    pub const json_field_names = .{
        .saml = "saml",
        .iamidentitycenter = "iamidentitycenter",
        .iamfederation = "iamfederation",
    };
};
