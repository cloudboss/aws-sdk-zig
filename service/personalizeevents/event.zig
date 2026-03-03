const MetricAttribution = @import("metric_attribution.zig").MetricAttribution;

/// Represents item interaction event information sent using the
/// `PutEvents` API.
pub const Event = struct {
    /// An ID associated with the event. If an event ID is not provided, Amazon
    /// Personalize generates
    /// a unique ID for the event. An event ID is not used as an input to the model.
    /// Amazon Personalize uses
    /// the event ID to distinguish unique events. Any subsequent events after the
    /// first with the
    /// same event ID are not used in model training.
    event_id: ?[]const u8 = null,

    /// The type of event, such as click or download. This property corresponds to
    /// the `EVENT_TYPE`
    /// field of your Item interactions dataset's schema and depends on the types of
    /// events you are tracking.
    event_type: []const u8,

    /// The event value that corresponds to the `EVENT_VALUE` field of the Item
    /// interactions schema.
    event_value: ?f32 = null,

    /// A list of item IDs that represents the sequence of items you have shown the
    /// user. For example, `["itemId1", "itemId2", "itemId3"]`. Provide a list of
    /// items to manually record impressions data for an event. For more information
    /// on recording impressions data,
    /// see [Recording impressions
    /// data](https://docs.aws.amazon.com/personalize/latest/dg/recording-events.html#putevents-including-impressions-data).
    impression: ?[]const []const u8 = null,

    /// The item ID key that corresponds to the `ITEM_ID` field of the Item
    /// interactions dataset's schema.
    item_id: ?[]const u8 = null,

    /// Contains information about the metric attribution associated with an event.
    /// For more information about metric attributions, see [Measuring impact of
    /// recommendations](https://docs.aws.amazon.com/personalize/latest/dg/measuring-recommendation-impact.html).
    metric_attribution: ?MetricAttribution = null,

    /// A string map of event-specific data that you might choose to record. For
    /// example, if a
    /// user rates a movie on your site, other than movie ID (`itemId`) and rating
    /// (`eventValue`)
    /// , you might also send the number of movie ratings made by the user.
    ///
    /// Each item in the map consists of a key-value pair. For example,
    ///
    /// `{"numberOfRatings": "12"}`
    ///
    /// The keys use camel case names that match the fields in the Item interactions
    /// dataset's
    /// schema. In the above example, the `numberOfRatings` would match the
    /// 'NUMBER_OF_RATINGS' field defined in the Item interactions dataset's schema.
    ///
    /// The following can't be included as a keyword for properties (case
    /// insensitive).
    ///
    /// * userId
    ///
    /// * sessionId
    ///
    /// * eventType
    ///
    /// * timestamp
    ///
    /// * recommendationId
    ///
    /// * impression
    properties: ?[]const u8 = null,

    /// The ID of the list of recommendations that contains the item the user
    /// interacted with. Provide a `recommendationId` to have Amazon Personalize
    /// implicitly record the
    /// recommendations you show your user as impressions data. Or provide a
    /// `recommendationId` if you use a metric attribution to measure the impact of
    /// recommendations.
    ///
    /// For more information on recording impressions data, see [Recording
    /// impressions
    /// data](https://docs.aws.amazon.com/personalize/latest/dg/recording-events.html#putevents-including-impressions-data).
    /// For more information on creating a metric attribution see [Measuring impact
    /// of
    /// recommendations](https://docs.aws.amazon.com/personalize/latest/dg/measuring-recommendation-impact.html).
    recommendation_id: ?[]const u8 = null,

    /// The timestamp (in Unix time) on the client side when the event occurred.
    sent_at: i64,

    pub const json_field_names = .{
        .event_id = "eventId",
        .event_type = "eventType",
        .event_value = "eventValue",
        .impression = "impression",
        .item_id = "itemId",
        .metric_attribution = "metricAttribution",
        .properties = "properties",
        .recommendation_id = "recommendationId",
        .sent_at = "sentAt",
    };
};
