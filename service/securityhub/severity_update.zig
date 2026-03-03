const SeverityLabel = @import("severity_label.zig").SeverityLabel;

/// Updates to the severity information for a finding.
pub const SeverityUpdate = struct {
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
    label: ?SeverityLabel = null,

    /// The normalized severity for the finding. This attribute is to be deprecated
    /// in favor of
    /// `Label`.
    ///
    /// If you provide `Normalized` and don't provide `Label`,
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
    normalized: ?i32 = null,

    /// The native severity as defined by the Amazon Web Services service or
    /// integrated partner product that
    /// generated the finding.
    product: ?f64 = null,

    pub const json_field_names = .{
        .label = "Label",
        .normalized = "Normalized",
        .product = "Product",
    };
};
