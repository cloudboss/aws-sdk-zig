const Capability = @import("capability.zig").Capability;
const GeoMatchLevel = @import("geo_match_level.zig").GeoMatchLevel;
const GeoMatchParams = @import("geo_match_params.zig").GeoMatchParams;
const NumberSelectionBehavior = @import("number_selection_behavior.zig").NumberSelectionBehavior;
const Participant = @import("participant.zig").Participant;
const ProxySessionStatus = @import("proxy_session_status.zig").ProxySessionStatus;

/// The proxy session for an Amazon Chime SDK Voice Connector.
pub const ProxySession = struct {
    /// The proxy session capabilities.
    capabilities: ?[]const Capability = null,

    /// The created time stamp, in ISO 8601 format.
    created_timestamp: ?i64 = null,

    /// The ended time stamp, in ISO 8601 format.
    ended_timestamp: ?i64 = null,

    /// The number of minutes allowed for the proxy session.
    expiry_minutes: ?i32 = null,

    /// The preference for matching the country or area code of the proxy phone
    /// number with that of the first participant.
    geo_match_level: ?GeoMatchLevel = null,

    /// The country and area code for the proxy phone number.
    geo_match_params: ?GeoMatchParams = null,

    /// The proxy session name.
    name: ?[]const u8 = null,

    /// The preference for proxy phone number reuse, or stickiness, between the same
    /// participants across sessions.
    number_selection_behavior: ?NumberSelectionBehavior = null,

    /// The proxy session participants.
    participants: ?[]const Participant = null,

    /// The proxy session ID.
    proxy_session_id: ?[]const u8 = null,

    /// The proxy session status.
    status: ?ProxySessionStatus = null,

    /// The updated time stamp, in ISO 8601 format.
    updated_timestamp: ?i64 = null,

    /// The Voice Connector ID.
    voice_connector_id: ?[]const u8 = null,

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
