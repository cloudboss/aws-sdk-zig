const Attribute = @import("attribute.zig").Attribute;
const FindingSeverity = @import("finding_severity.zig").FindingSeverity;

/// Contains information about an image scan finding.
pub const ImageScanFinding = struct {
    /// A collection of attributes of the host from which the finding is generated.
    attributes: ?[]const Attribute,

    /// The description of the finding.
    description: ?[]const u8,

    /// The name associated with the finding, usually a CVE number.
    name: ?[]const u8,

    /// The finding severity.
    severity: ?FindingSeverity,

    /// A link containing additional details about the security vulnerability.
    uri: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .description = "description",
        .name = "name",
        .severity = "severity",
        .uri = "uri",
    };
};
