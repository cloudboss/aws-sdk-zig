const DestinationType = @import("destination_type.zig").DestinationType;

/// Contains information about the destination receiving events.
pub const Destination = struct {
    /// For channels used for a CloudTrail Lake integration, the location is the ARN
    /// of an event data store that receives events from a channel.
    /// For service-linked channels, the location is the name of the Amazon Web
    /// Services service.
    location: []const u8,

    /// The type of destination for events arriving from a channel. For channels
    /// used for a CloudTrail Lake integration, the value is `EVENT_DATA_STORE`. For
    /// service-linked channels,
    /// the value is `AWS_SERVICE`.
    type: DestinationType,

    pub const json_field_names = .{
        .location = "Location",
        .type = "Type",
    };
};
