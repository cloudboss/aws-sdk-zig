const PiiType = @import("pii_type.zig").PiiType;

/// Specifies a transform that identifies, removes or masks PII data.
pub const PIIDetection = struct {
    /// Additional parameters for configuring PII detection behavior and sensitivity
    /// settings.
    detection_parameters: ?[]const u8,

    /// The sensitivity level for PII detection. Higher sensitivity levels detect
    /// more potential PII but may result in more false positives.
    detection_sensitivity: ?[]const u8,

    /// Indicates the types of entities the PIIDetection transform will identify as
    /// PII data.
    ///
    /// PII type entities include: PERSON_NAME, DATE, USA_SNN, EMAIL, USA_ITIN,
    /// USA_PASSPORT_NUMBER, PHONE_NUMBER, BANK_ACCOUNT,
    /// IP_ADDRESS, MAC_ADDRESS, USA_CPT_CODE, USA_HCPCS_CODE,
    /// USA_NATIONAL_DRUG_CODE, USA_MEDICARE_BENEFICIARY_IDENTIFIER,
    /// USA_HEALTH_INSURANCE_CLAIM_NUMBER,CREDIT_CARD,USA_NATIONAL_PROVIDER_IDENTIFIER,USA_DEA_NUMBER,USA_DRIVING_LICENSE
    entity_types_to_detect: []const []const u8,

    /// The node ID inputs to the transform.
    inputs: []const []const u8,

    /// Indicates the value that will replace the detected entity.
    mask_value: ?[]const u8,

    /// A regular expression pattern used to identify additional PII content beyond
    /// the standard detection algorithms.
    match_pattern: ?[]const u8,

    /// The name of the transform node.
    name: []const u8,

    /// The number of characters to exclude from redaction on the left side of
    /// detected PII content. This allows preserving context around the sensitive
    /// data.
    num_left_chars_to_exclude: ?i32,

    /// The number of characters to exclude from redaction on the right side of
    /// detected PII content. This allows preserving context around the sensitive
    /// data.
    num_right_chars_to_exclude: ?i32,

    /// Indicates the output column name that will contain any entity type detected
    /// in that row.
    output_column_name: ?[]const u8,

    /// Indicates the type of PIIDetection transform.
    pii_type: PiiType,

    /// The character used to replace detected PII content when redaction is
    /// enabled. The default redaction character is `*`.
    redact_char: ?[]const u8,

    /// Specifies whether to redact the detected PII text. When set to `true`, PII
    /// content is replaced with redaction characters.
    redact_text: ?[]const u8,

    /// Indicates the fraction of the data to sample when scanning for PII entities.
    sample_fraction: ?f64,

    /// Indicates the fraction of the data that must be met in order for a column to
    /// be identified as PII data.
    threshold_fraction: ?f64,

    pub const json_field_names = .{
        .detection_parameters = "DetectionParameters",
        .detection_sensitivity = "DetectionSensitivity",
        .entity_types_to_detect = "EntityTypesToDetect",
        .inputs = "Inputs",
        .mask_value = "MaskValue",
        .match_pattern = "MatchPattern",
        .name = "Name",
        .num_left_chars_to_exclude = "NumLeftCharsToExclude",
        .num_right_chars_to_exclude = "NumRightCharsToExclude",
        .output_column_name = "OutputColumnName",
        .pii_type = "PiiType",
        .redact_char = "RedactChar",
        .redact_text = "RedactText",
        .sample_fraction = "SampleFraction",
        .threshold_fraction = "ThresholdFraction",
    };
};
