const ComponentConfig = @import("component_config.zig").ComponentConfig;
const ScraperComponentType = @import("scraper_component_type.zig").ScraperComponentType;

/// A component of a Amazon Managed Service for Prometheus scraper that can be
/// configured for logging.
pub const ScraperComponent = struct {
    /// The configuration settings for the scraper component.
    config: ?ComponentConfig,

    /// The type of the scraper component.
    type: ScraperComponentType,

    pub const json_field_names = .{
        .config = "config",
        .type = "type",
    };
};
