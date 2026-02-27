const AdsInteractionExcludeEventType = @import("ads_interaction_exclude_event_type.zig").AdsInteractionExcludeEventType;
const AdsInteractionPublishOptInEventType = @import("ads_interaction_publish_opt_in_event_type.zig").AdsInteractionPublishOptInEventType;

/// Settings for customizing what events are included in logs for interactions
/// with the ad decision server (ADS).
///
/// For more information about ADS logs, inlcuding descriptions of the event
/// types, see [MediaTailor ADS logs description and event
/// types](https://docs.aws.amazon.com/mediatailor/latest/ug/ads-log-format.html) in Elemental MediaTailor User Guide.
pub const AdsInteractionLog = struct {
    /// Indicates that MediaTailor won't emit the selected events in the logs for
    /// playback sessions that are initialized with this configuration.
    exclude_event_types: ?[]const AdsInteractionExcludeEventType,

    /// Indicates that MediaTailor emits `RAW_ADS_RESPONSE` logs for playback
    /// sessions that are initialized with this configuration.
    publish_opt_in_event_types: ?[]const AdsInteractionPublishOptInEventType,

    pub const json_field_names = .{
        .exclude_event_types = "ExcludeEventTypes",
        .publish_opt_in_event_types = "PublishOptInEventTypes",
    };
};
