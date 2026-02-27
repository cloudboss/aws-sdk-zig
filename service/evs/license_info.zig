/// The license information that Amazon EVS requires to create an environment.
/// Amazon EVS requires two license keys: a VCF solution key and a vSAN license
/// key.
pub const LicenseInfo = struct {
    /// The VCF solution key. This license unlocks VMware VCF product features,
    /// including vSphere, NSX, SDDC Manager, and vCenter Server. The VCF solution
    /// key must cover a minimum of 256 cores.
    solution_key: []const u8,

    /// The VSAN license key. This license unlocks vSAN features. The vSAN license
    /// key must provide at least 110 TiB of vSAN capacity.
    vsan_key: []const u8,

    pub const json_field_names = .{
        .solution_key = "solutionKey",
        .vsan_key = "vsanKey",
    };
};
