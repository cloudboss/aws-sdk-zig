const AmdSevSnpEnum = @import("amd_sev_snp_enum.zig").AmdSevSnpEnum;
const NestedVirtualizationEnum = @import("nested_virtualization_enum.zig").NestedVirtualizationEnum;

/// Configures CPU-specific settings for WorkSpace Instance.
pub const CpuOptionsRequest = struct {
    /// AMD Secure Encrypted Virtualization configuration.
    amd_sev_snp: ?AmdSevSnpEnum = null,

    /// Number of CPU cores to allocate.
    core_count: ?i32 = null,

    /// Specifies whether to enable or disable nested virtualization.
    nested_virtualization: ?NestedVirtualizationEnum = null,

    /// Number of threads per CPU core.
    threads_per_core: ?i32 = null,

    pub const json_field_names = .{
        .amd_sev_snp = "AmdSevSnp",
        .core_count = "CoreCount",
        .nested_virtualization = "NestedVirtualization",
        .threads_per_core = "ThreadsPerCore",
    };
};
