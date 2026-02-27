pub const ConnectorConfigProvider = enum {
    eks_anywhere,
    anthos,
    gke,
    aks,
    openshift,
    tanzu,
    rancher,
    ec2,
    other,

    pub const json_field_names = .{
        .eks_anywhere = "EKS_ANYWHERE",
        .anthos = "ANTHOS",
        .gke = "GKE",
        .aks = "AKS",
        .openshift = "OPENSHIFT",
        .tanzu = "TANZU",
        .rancher = "RANCHER",
        .ec2 = "EC2",
        .other = "OTHER",
    };
};
