pub const CapabilityType = enum {
    ack,
    kro,
    argocd,

    pub const json_field_names = .{
        .ack = "ACK",
        .kro = "KRO",
        .argocd = "ARGOCD",
    };
};
