pub const DatasourcePackage = enum {
    detective_core,
    eks_audit,
    asff_securityhub_finding,

    pub const json_field_names = .{
        .detective_core = "DETECTIVE_CORE",
        .eks_audit = "EKS_AUDIT",
        .asff_securityhub_finding = "ASFF_SECURITYHUB_FINDING",
    };
};
