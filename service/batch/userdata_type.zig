pub const UserdataType = enum {
    eks_bootstrap_sh,
    eks_nodeadm,

    pub const json_field_names = .{
        .eks_bootstrap_sh = "EKS_BOOTSTRAP_SH",
        .eks_nodeadm = "EKS_NODEADM",
    };
};
