/// Contains information about a metric attribution associated with an event.
/// For more information about metric attributions, see [Measuring impact of
/// recommendations](https://docs.aws.amazon.com/personalize/latest/dg/measuring-recommendation-impact.html).
pub const MetricAttribution = struct {
    /// The source of the event, such as a third party.
    event_attribution_source: []const u8,

    pub const json_field_names = .{
        .event_attribution_source = "eventAttributionSource",
    };
};
