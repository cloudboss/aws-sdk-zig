const Capability = @import("capability.zig").Capability;
const GeoMatchLevel = @import("geo_match_level.zig").GeoMatchLevel;
const GeoMatchParams = @import("geo_match_params.zig").GeoMatchParams;
const NumberSelectionBehavior = @import("number_selection_behavior.zig").NumberSelectionBehavior;
const Participant = @import("participant.zig").Participant;
const ProxySessionStatus = @import("proxy_session_status.zig").ProxySessionStatus;

/// The proxy session for an Amazon Chime SDK Voice Connector.
pub const ProxySession = struct {
    /// The proxy session capabilities.
    capabilities: ?[]const Capability,

    /// The created time stamp, in ISO 8601 format.
    created_timestamp: ?i64,

    /// The ended time stamp, in ISO 8601 format.
    ended_timestamp: ?i64,

    /// The number of minutes allowed for the proxy session.
    expiry_minutes: ?i32,

    /// The preference for matching the country or area code of the proxy phone
    /// number with that of the first participant.
    geo_match_level: ?GeoMatchLevel,

    /// The country and area code for the proxy phone number.
    geo_match_params: ?GeoMatchParams,

    /// The proxy session name.
    name: ?[]const u8,

    /// The preference for proxy phone number reuse, or stickiness, between the same
    /// participants across sessions.
    number_selection_behavior: ?NumberSelectionBehavior,

    /// The proxy session participants.
    participants: ?[]const Participant,

    /// The proxy session ID.
    proxy_session_id: ?[]const u8,

    /// The proxy session status.
    status: ?ProxySessionStatus,

    /// The updated time stamp, in ISO 8601 format.
    updated_timestamp: ?i64,

    /// The Voice Connector ID.
    voice_connector_id: ?[]const u8,

    pub const json_field_names = .{
        .capabilities = "Capabilities",
        .created_timestamp = "CreatedTimestamp",
        .ended_timestamp = "EndedTimestamp",
        .expiry_minutes = "ExpiryMinutes",
        .geo_match_level = "GeoMatchLevel",
        .geo_match_params = "GeoMatchParams",
        .name = "Name",
        .number_selection_behavior = "NumberSelectionBehavior",
        .participants = "Participants",
        .proxy_session_id = "ProxySessionId",
        .status = "Status",
        .updated_timestamp = "UpdatedTimestamp",
        .voice_connector_id = "VoiceConnectorId",
    };
};
