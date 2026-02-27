/// The confidence level threshold for suppression validation:
///
/// * `MEDIUM` – Allows emails to be sent to addresses with medium or high
///   delivery likelihood.
///
/// * `HIGH` – Allows emails to be sent only to addresses with high delivery
///   likelihood.
///
/// * `MANAGED` – Managed confidence threshold where Amazon SES automatically
///   determines the appropriate level.
pub const SuppressionConfidenceVerdictThreshold = enum {
    medium,
    high,
    managed,

    pub const json_field_names = .{
        .medium = "MEDIUM",
        .high = "HIGH",
        .managed = "MANAGED",
    };
};
