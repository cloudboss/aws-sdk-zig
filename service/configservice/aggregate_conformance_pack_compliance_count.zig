/// The number of conformance packs that are compliant and noncompliant.
pub const AggregateConformancePackComplianceCount = struct {
    /// Number of compliant conformance packs.
    compliant_conformance_pack_count: i32 = 0,

    /// Number of noncompliant conformance packs.
    non_compliant_conformance_pack_count: i32 = 0,

    pub const json_field_names = .{
        .compliant_conformance_pack_count = "CompliantConformancePackCount",
        .non_compliant_conformance_pack_count = "NonCompliantConformancePackCount",
    };
};
