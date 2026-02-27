const AdvancedEventSelector = @import("advanced_event_selector.zig").AdvancedEventSelector;

/// Parameters specific to Amazon Web Services CloudTrail telemetry
/// configuration.
pub const CloudtrailParameters = struct {
    /// The advanced event selectors to use for filtering Amazon Web Services
    /// CloudTrail events.
    advanced_event_selectors: []const AdvancedEventSelector,

    pub const json_field_names = .{
        .advanced_event_selectors = "AdvancedEventSelectors",
    };
};
