const AdvancedEventSelector = @import("advanced_event_selector.zig").AdvancedEventSelector;

/// Contains configuration information about the channel.
pub const SourceConfig = struct {
    /// The advanced event selectors that are configured for the channel.
    advanced_event_selectors: ?[]const AdvancedEventSelector = null,

    /// Specifies whether the channel applies to a single Region or to all Regions.
    apply_to_all_regions: ?bool = null,

    pub const json_field_names = .{
        .advanced_event_selectors = "AdvancedEventSelectors",
        .apply_to_all_regions = "ApplyToAllRegions",
    };
};
