const AmdSevSnpSpecification = @import("amd_sev_snp_specification.zig").AmdSevSnpSpecification;
const NestedVirtualizationSpecification = @import("nested_virtualization_specification.zig").NestedVirtualizationSpecification;

/// The CPU options for the instance.
pub const CpuOptions = struct {
    /// Indicates whether the instance is enabled for AMD SEV-SNP. For more
    /// information, see
    /// [AMD
    /// SEV-SNP](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/sev-snp.html).
    amd_sev_snp: ?AmdSevSnpSpecification = null,

    /// The number of CPU cores for the instance.
    core_count: ?i32 = null,

    /// Indicates whether the instance is enabled for nested virtualization.
    nested_virtualization: ?NestedVirtualizationSpecification = null,

    /// The number of threads per CPU core.
    threads_per_core: ?i32 = null,
};
