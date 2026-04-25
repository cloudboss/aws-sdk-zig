const ThreatIntelIndicatorCategory = @import("threat_intel_indicator_category.zig").ThreatIntelIndicatorCategory;
const ThreatIntelIndicatorType = @import("threat_intel_indicator_type.zig").ThreatIntelIndicatorType;

/// Details about the threat intelligence related to a finding.
pub const ThreatIntelIndicator = struct {
    /// The category of a threat intelligence indicator.
    category: ?ThreatIntelIndicatorCategory = null,

    /// Indicates when the most recent instance of a threat intelligence indicator
    /// was
    /// observed.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    last_observed_at: ?[]const u8 = null,

    /// The source of the threat intelligence indicator.
    ///
    /// Length Constraints: Minimum of 1 length. Maximum of 64 length.
    source: ?[]const u8 = null,

    /// The URL to the page or site where you can get more information about the
    /// threat
    /// intelligence indicator.
    source_url: ?[]const u8 = null,

    /// The type of threat intelligence indicator.
    @"type": ?ThreatIntelIndicatorType = null,

    /// The value of a threat intelligence indicator.
    ///
    /// Length Constraints: Minimum of 1 length. Maximum of 512 length.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .category = "Category",
        .last_observed_at = "LastObservedAt",
        .source = "Source",
        .source_url = "SourceUrl",
        .@"type" = "Type",
        .value = "Value",
    };
};
