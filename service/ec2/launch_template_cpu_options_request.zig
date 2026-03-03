const AmdSevSnpSpecification = @import("amd_sev_snp_specification.zig").AmdSevSnpSpecification;

/// The CPU options for the instance. Both the core count and threads per core
/// must be
/// specified in the request.
pub const LaunchTemplateCpuOptionsRequest = struct {
    /// Indicates whether to enable the instance for AMD SEV-SNP. AMD SEV-SNP is
    /// supported
    /// with M6a, R6a, and C6a instance types only. For more information, see [AMD
    /// SEV-SNP for
    /// Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/sev-snp.html).
    amd_sev_snp: ?AmdSevSnpSpecification = null,

    /// The number of CPU cores for the instance.
    core_count: ?i32 = null,

    /// The number of threads per CPU core. To disable multithreading for the
    /// instance,
    /// specify a value of `1`. Otherwise, specify the default value of
    /// `2`.
    threads_per_core: ?i32 = null,
};
