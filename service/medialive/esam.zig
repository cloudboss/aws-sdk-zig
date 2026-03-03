/// Esam
pub const Esam = struct {
    /// Sent as acquisitionPointIdentity to identify the MediaLive channel to the
    /// POIS.
    acquisition_point_id: []const u8,

    /// When specified, this offset (in milliseconds) is added to the input Ad Avail
    /// PTS time. This only applies to embedded SCTE 104/35 messages and does not
    /// apply to OOB messages.
    ad_avail_offset: ?i32 = null,

    /// Documentation update needed
    password_param: ?[]const u8 = null,

    /// The URL of the signal conditioner endpoint on the Placement Opportunity
    /// Information System (POIS). MediaLive sends SignalProcessingEvents here when
    /// SCTE-35 messages are read.
    pois_endpoint: []const u8,

    /// Documentation update needed
    username: ?[]const u8 = null,

    /// Optional data sent as zoneIdentity to identify the MediaLive channel to the
    /// POIS.
    zone_identity: ?[]const u8 = null,

    pub const json_field_names = .{
        .acquisition_point_id = "AcquisitionPointId",
        .ad_avail_offset = "AdAvailOffset",
        .password_param = "PasswordParam",
        .pois_endpoint = "PoisEndpoint",
        .username = "Username",
        .zone_identity = "ZoneIdentity",
    };
};
