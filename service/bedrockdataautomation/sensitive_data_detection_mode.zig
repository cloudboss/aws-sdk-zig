/// Mode for sensitive data detection
pub const SensitiveDataDetectionMode = enum {
    /// Only detect sensitive data without redaction
    detection,
    /// Detect and redact sensitive data
    detection_and_redaction,

    pub const json_field_names = .{
        .detection = "DETECTION",
        .detection_and_redaction = "DETECTION_AND_REDACTION",
    };
};
