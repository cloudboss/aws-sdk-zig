const AnalyticsMode = @import("analytics_mode.zig").AnalyticsMode;
const ReferenceStatus = @import("reference_status.zig").ReferenceStatus;

/// Information about a reference when the `referenceType` is
/// `CONTACT_ANALYSIS`. Otherwise,
/// null.
pub const ContactAnalysisReference = struct {
    /// The analytics mode of the contact analysis.
    analytics_mode: ?AnalyticsMode = null,

    /// The Amazon Resource Name (ARN) of the contact analysis reference.
    arn: ?[]const u8 = null,

    /// Indicates whether sensitive data has been redacted from the contact
    /// analysis.
    is_redacted: ?bool = null,

    /// Identifier of the contact analysis reference.
    name: ?[]const u8 = null,

    /// Status of the contact analysis reference type.
    status: ?ReferenceStatus = null,

    /// The location path of the contact analysis reference.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .analytics_mode = "AnalyticsMode",
        .arn = "Arn",
        .is_redacted = "IsRedacted",
        .name = "Name",
        .status = "Status",
        .value = "Value",
    };
};
