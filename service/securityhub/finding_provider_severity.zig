const SeverityLabel = @import("severity_label.zig").SeverityLabel;

/// The severity assigned to a finding by the finding provider. This object may
/// include one or more of the following
/// attributes:
///
/// * `Label`
///
/// * `Normalized`
///
/// * `Original`
///
/// * `Product`
///
/// If a [
/// `BatchImportFindings`
/// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchImportFindings.html) request for a
/// new finding only provides `Label` or only provides `Normalized`, Security
/// Hub
/// automatically populates the value of the other field.
///
/// The `Normalized` and `Product` attributes are included in the
/// `FindingProviderSeverity`
/// structure to preserve the historical information associated with the
/// finding, even if the top-level
/// `Severity` object is later modified using the [
/// `BatchUpdateFindings`
/// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchUpdateFindings.html) operation.
///
/// If the top-level `Finding.Severity` object is present, but
/// `Finding.FindingProviderFields` isn't present,
/// Security Hub creates the `FindingProviderFields.Severity` object and copies
/// the entire `Finding.Severity` object into it.
/// This ensures that the original, provider-supplied details are retained
/// within the `FindingProviderFields.Severity`
/// object, even if the top-level `Severity` object is overwritten.
pub const FindingProviderSeverity = struct {
    /// The severity label assigned to the finding by the finding provider.
    label: ?SeverityLabel = null,

    /// The finding provider's original value for the severity.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 64.
    original: ?[]const u8 = null,

    pub const json_field_names = .{
        .label = "Label",
        .original = "Original",
    };
};
