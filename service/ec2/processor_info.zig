const ArchitectureType = @import("architecture_type.zig").ArchitectureType;
const SupportedAdditionalProcessorFeature = @import("supported_additional_processor_feature.zig").SupportedAdditionalProcessorFeature;

/// Describes the processor used by the instance type.
pub const ProcessorInfo = struct {
    /// The manufacturer of the processor.
    manufacturer: ?[]const u8 = null,

    /// The architectures supported by the instance type.
    supported_architectures: ?[]const ArchitectureType = null,

    /// Indicates whether the instance type supports AMD SEV-SNP. If the request
    /// returns
    /// `amd-sev-snp`, AMD SEV-SNP is supported. Otherwise, it is not supported. For
    /// more
    /// information, see [ AMD
    /// SEV-SNP](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/sev-snp.html).
    supported_features: ?[]const SupportedAdditionalProcessorFeature = null,

    /// The speed of the processor, in GHz.
    sustained_clock_speed_in_ghz: ?f64 = null,
};
