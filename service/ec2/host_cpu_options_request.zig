const AmdSevSnp = @import("amd_sev_snp.zig").AmdSevSnp;

/// Contains the CPU configuration options for a Dedicated Host allocation
/// request. Options include AMD Secure Encrypted Virtualization-Secure Nested
/// Paging (AMD SEV-SNP) settings.
pub const HostCpuOptionsRequest = struct {
    /// Specifies whether AMD Secure Encrypted Virtualization-Secure Nested Paging
    /// (AMD SEV-SNP) is enabled or disabled for the Dedicated Host. If you don't
    /// specify a value, AMD SEV-SNP is `disabled`.
    amd_sev_snp: ?AmdSevSnp = null,
};
