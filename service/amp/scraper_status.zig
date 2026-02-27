const ScraperStatusCode = @import("scraper_status_code.zig").ScraperStatusCode;

/// The `ScraperStatus` structure contains status information about the scraper.
pub const ScraperStatus = struct {
    /// The current status of the scraper.
    status_code: ScraperStatusCode,

    pub const json_field_names = .{
        .status_code = "statusCode",
    };
};
