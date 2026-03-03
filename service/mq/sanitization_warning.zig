const SanitizationWarningReason = @import("sanitization_warning_reason.zig").SanitizationWarningReason;

/// Returns information about the configuration element or attribute that was
/// sanitized in the configuration.
pub const SanitizationWarning = struct {
    /// The name of the configuration attribute that has been sanitized.
    attribute_name: ?[]const u8 = null,

    /// The name of the configuration element that has been sanitized.
    element_name: ?[]const u8 = null,

    /// The reason for which the configuration elements or attributes were
    /// sanitized.
    reason: SanitizationWarningReason,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .element_name = "ElementName",
        .reason = "Reason",
    };
};
