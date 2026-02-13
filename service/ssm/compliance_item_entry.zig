const aws = @import("aws");

const ComplianceSeverity = @import("compliance_severity.zig").ComplianceSeverity;
const ComplianceStatus = @import("compliance_status.zig").ComplianceStatus;

/// Information about a compliance item.
pub const ComplianceItemEntry = struct {
    /// A "Key": "Value" tag combination for the compliance item.
    details: ?[]const aws.map.StringMapEntry,

    /// The compliance item ID. For example, if the compliance item is a Windows
    /// patch, the ID could
    /// be the number of the KB article.
    id: ?[]const u8,

    /// The severity of the compliance status. Severity can be one of the following:
    /// Critical, High,
    /// Medium, Low, Informational, Unspecified.
    severity: ComplianceSeverity,

    /// The status of the compliance item. An item is either COMPLIANT or
    /// NON_COMPLIANT.
    status: ComplianceStatus,

    /// The title of the compliance item. For example, if the compliance item is a
    /// Windows patch,
    /// the title could be the title of the KB article for the patch; for example:
    /// Security Update for
    /// Active Directory Federation Services.
    title: ?[]const u8,

    pub const json_field_names = .{
        .details = "Details",
        .id = "Id",
        .severity = "Severity",
        .status = "Status",
        .title = "Title",
    };
};
