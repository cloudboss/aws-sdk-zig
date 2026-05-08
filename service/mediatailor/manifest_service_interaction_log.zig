const ManifestServiceExcludeEventType = @import("manifest_service_exclude_event_type.zig").ManifestServiceExcludeEventType;
const ManifestServicePublishOptInEventType = @import("manifest_service_publish_opt_in_event_type.zig").ManifestServicePublishOptInEventType;

/// Settings for customizing what events are included in logs for interactions
/// with the origin server.
///
/// For more information about manifest service logs, including descriptions of
/// the event types, see [MediaTailor manifest logs description and event
/// types](https://docs.aws.amazon.com/mediatailor/latest/ug/log-types.html) in
/// Elemental MediaTailor User Guide.
pub const ManifestServiceInteractionLog = struct {
    /// Indicates that MediaTailor won't emit the selected events in the logs for
    /// playback sessions that are initialized with this configuration.
    exclude_event_types: ?[]const ManifestServiceExcludeEventType = null,

    /// Indicates that MediaTailor will emit the selected events in the logs for
    /// playback sessions that are initialized with this configuration. These events
    /// are not emitted by default and must be explicitly opted in.
    publish_opt_in_event_types: ?[]const ManifestServicePublishOptInEventType = null,

    pub const json_field_names = .{
        .exclude_event_types = "ExcludeEventTypes",
        .publish_opt_in_event_types = "PublishOptInEventTypes",
    };
};
