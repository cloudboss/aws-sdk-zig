pub const ScraperComponentType = enum {
    /// Scraper service discoverer component
    service_discovery,
    /// Scraper collector component
    collector,
    /// Scraper exporter component
    exporter,

    pub const json_field_names = .{
        .service_discovery = "SERVICE_DISCOVERY",
        .collector = "COLLECTOR",
        .exporter = "EXPORTER",
    };
};
