pub const ClusterAutoScalerType = enum {
    karpenter,

    pub const json_field_names = .{
        .karpenter = "KARPENTER",
    };
};
