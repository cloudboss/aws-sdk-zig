const Resource = @import("resource.zig").Resource;

/// Contains information about an event that was returned by a lookup request.
/// The result
/// includes a representation of a CloudTrail event.
pub const Event = struct {
    /// The Amazon Web Services access key ID that was used to sign the request. If
    /// the request
    /// was made with temporary security credentials, this is the access key ID of
    /// the temporary
    /// credentials.
    access_key_id: ?[]const u8 = null,

    /// A JSON string that contains a representation of the event returned.
    cloud_trail_event: ?[]const u8 = null,

    /// The CloudTrail ID of the event returned.
    event_id: ?[]const u8 = null,

    /// The name of the event returned.
    event_name: ?[]const u8 = null,

    /// The Amazon Web Services service to which the request was made.
    event_source: ?[]const u8 = null,

    /// The date and time of the event returned.
    event_time: ?i64 = null,

    /// Information about whether the event is a write event or a read event.
    read_only: ?[]const u8 = null,

    /// A list of resources referenced by the event returned.
    resources: ?[]const Resource = null,

    /// A user name or role name of the requester that called the API in the event
    /// returned.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_key_id = "AccessKeyId",
        .cloud_trail_event = "CloudTrailEvent",
        .event_id = "EventId",
        .event_name = "EventName",
        .event_source = "EventSource",
        .event_time = "EventTime",
        .read_only = "ReadOnly",
        .resources = "Resources",
        .username = "Username",
    };
};
