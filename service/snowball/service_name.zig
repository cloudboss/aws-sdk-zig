pub const ServiceName = enum {
    kubernetes,
    eks_anywhere,

    pub const json_field_names = .{
        .kubernetes = "KUBERNETES",
        .eks_anywhere = "EKS_ANYWHERE",
    };
};
