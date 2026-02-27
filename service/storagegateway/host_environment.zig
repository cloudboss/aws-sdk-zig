pub const HostEnvironment = enum {
    vmware,
    hyper_v,
    ec2,
    kvm,
    other,
    snowball,

    pub const json_field_names = .{
        .vmware = "VMWARE",
        .hyper_v = "HYPER_V",
        .ec2 = "EC2",
        .kvm = "KVM",
        .other = "OTHER",
        .snowball = "SNOWBALL",
    };
};
