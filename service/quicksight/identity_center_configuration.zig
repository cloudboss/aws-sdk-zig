/// The parameters for an IAM Identity Center configuration.
pub const IdentityCenterConfiguration = struct {
    /// A Boolean option that controls whether Trusted Identity Propagation should
    /// be used.
    enable_identity_propagation: ?bool = null,

    pub const json_field_names = .{
        .enable_identity_propagation = "EnableIdentityPropagation",
    };
};
