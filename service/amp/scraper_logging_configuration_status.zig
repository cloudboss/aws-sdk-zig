const ScraperLoggingConfigurationStatusCode = @import("scraper_logging_configuration_status_code.zig").ScraperLoggingConfigurationStatusCode;

/// The status of a scraper logging configuration.
pub const ScraperLoggingConfigurationStatus = struct {
    /// The status code of the scraper logging configuration.
    status_code: ScraperLoggingConfigurationStatusCode,

    /// The reason for the current status of the scraper logging configuration.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .status_code = "statusCode",
        .status_reason = "statusReason",
    };
};
