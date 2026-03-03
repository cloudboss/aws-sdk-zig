const aws = @import("aws");

/// Configuration settings for a scraper component.
pub const ComponentConfig = struct {
    /// Configuration options for the scraper component.
    options: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .options = "options",
    };
};
