const ConformancePackComplianceType = @import("conformance_pack_compliance_type.zig").ConformancePackComplianceType;

/// Summary includes the name and status of the conformance pack.
pub const ConformancePackComplianceSummary = struct {
    /// The status of the conformance pack.
    conformance_pack_compliance_status: ConformancePackComplianceType,

    /// The name of the conformance pack name.
    conformance_pack_name: []const u8,

    pub const json_field_names = .{
        .conformance_pack_compliance_status = "ConformancePackComplianceStatus",
        .conformance_pack_name = "ConformancePackName",
    };
};
