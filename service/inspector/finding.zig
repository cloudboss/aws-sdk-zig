const AssetAttributes = @import("asset_attributes.zig").AssetAttributes;
const AssetType = @import("asset_type.zig").AssetType;
const Attribute = @import("attribute.zig").Attribute;
const InspectorServiceAttributes = @import("inspector_service_attributes.zig").InspectorServiceAttributes;
const Severity = @import("severity.zig").Severity;

/// Contains information about an Amazon Inspector finding. This data type is
/// used as the
/// response element in the DescribeFindings action.
pub const Finding = struct {
    /// The ARN that specifies the finding.
    arn: []const u8,

    /// A collection of attributes of the host from which the finding is generated.
    asset_attributes: ?AssetAttributes = null,

    /// The type of the host from which the finding is generated.
    asset_type: ?AssetType = null,

    /// The system-defined attributes for the finding.
    attributes: []const Attribute,

    /// This data element is currently not used.
    confidence: i32 = 0,

    /// The time when the finding was generated.
    created_at: i64,

    /// The description of the finding.
    description: ?[]const u8 = null,

    /// The ID of the finding.
    id: ?[]const u8 = null,

    /// This data element is currently not used.
    indicator_of_compromise: ?bool = null,

    /// The numeric value of the finding severity.
    numeric_severity: f64 = 0,

    /// The recommendation for the finding.
    recommendation: ?[]const u8 = null,

    /// The schema version of this data type.
    schema_version: i32 = 0,

    /// The data element is set to "Inspector".
    service: ?[]const u8 = null,

    /// This data type is used in the Finding data type.
    service_attributes: ?InspectorServiceAttributes = null,

    /// The finding severity. Values can be set to High, Medium, Low, and
    /// Informational.
    severity: ?Severity = null,

    /// The name of the finding.
    title: ?[]const u8 = null,

    /// The time when AddAttributesToFindings is called.
    updated_at: i64,

    /// The user-defined attributes that are assigned to the finding.
    user_attributes: []const Attribute,

    pub const json_field_names = .{
        .arn = "arn",
        .asset_attributes = "assetAttributes",
        .asset_type = "assetType",
        .attributes = "attributes",
        .confidence = "confidence",
        .created_at = "createdAt",
        .description = "description",
        .id = "id",
        .indicator_of_compromise = "indicatorOfCompromise",
        .numeric_severity = "numericSeverity",
        .recommendation = "recommendation",
        .schema_version = "schemaVersion",
        .service = "service",
        .service_attributes = "serviceAttributes",
        .severity = "severity",
        .title = "title",
        .updated_at = "updatedAt",
        .user_attributes = "userAttributes",
    };
};
