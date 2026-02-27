const SeverityLabel = @import("severity_label.zig").SeverityLabel;

/// The severity of the finding.
///
/// The finding provider can provide the initial severity. The finding provider
/// can only
/// update the severity if it hasn't been updated using
/// `BatchUpdateFindings`.
///
/// The finding must have either `Label` or `Normalized` populated. If
/// only one of these attributes is populated, then Security Hub automatically
/// populates the other
/// one. If neither attribute is populated, then the finding is invalid. `Label`
/// is
/// the preferred attribute.
pub const Severity = struct {
    /// The severity value of the finding. The allowed values are the following.
    ///
    /// * `INFORMATIONAL` - No issue was found.
    ///
    /// * `LOW` - The issue does not require action on its own.
    ///
    /// * `MEDIUM` - The issue must be addressed but not urgently.
    ///
    /// * `HIGH` - The issue must be addressed as a priority.
    ///
    /// * `CRITICAL` - The issue must be remediated immediately to avoid it
    /// escalating.
    ///
    /// If you provide `Normalized` and don't provide `Label`, then
    /// `Label` is set automatically as follows.
    ///
    /// * 0 - `INFORMATIONAL`
    ///
    /// * 1–39 - `LOW`
    ///
    /// * 40–69 - `MEDIUM`
    ///
    /// * 70–89 - `HIGH`
    ///
    /// * 90–100 - `CRITICAL`
    label: ?SeverityLabel,

    /// Deprecated. The normalized severity of a finding.
    /// Instead of providing `Normalized`, provide `Label`.
    ///
    /// The value of `Normalized` can be an integer between `0` and `100`.
    ///
    /// If you provide `Label` and don't provide `Normalized`, then
    /// `Normalized` is set automatically as follows.
    ///
    /// * `INFORMATIONAL` - 0
    ///
    /// * `LOW` - 1
    ///
    /// * `MEDIUM` - 40
    ///
    /// * `HIGH` - 70
    ///
    /// * `CRITICAL` - 90
    normalized: ?i32,

    /// The native severity from the finding product that generated the finding.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 64.
    original: ?[]const u8,

    /// Deprecated. This attribute isn't included in findings. Instead of providing
    /// `Product`, provide `Original`.
    ///
    /// The native severity as defined by the Amazon Web Services service or
    /// integrated partner product that
    /// generated the finding.
    product: ?f64,

    pub const json_field_names = .{
        .label = "Label",
        .normalized = "Normalized",
        .original = "Original",
        .product = "Product",
    };
};
