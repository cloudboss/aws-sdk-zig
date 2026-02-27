const CdmaLocalId = @import("cdma_local_id.zig").CdmaLocalId;
const CdmaNmrObj = @import("cdma_nmr_obj.zig").CdmaNmrObj;

/// CDMA (Code-division multiple access) object.
pub const CdmaObj = struct {
    /// CDMA base station latitude in degrees.
    base_lat: ?f32,

    /// CDMA base station longitude in degrees.
    base_lng: ?f32,

    /// CDMA base station ID (BSID).
    base_station_id: i32,

    /// CDMA local identification (local ID) parameters.
    cdma_local_id: ?CdmaLocalId,

    /// CDMA network measurement reports.
    cdma_nmr: ?[]const CdmaNmrObj,

    /// CDMA network ID (NID).
    network_id: i32,

    /// Transmit power level of the pilot signal, measured in dBm
    /// (decibel-milliwatts).
    pilot_power: ?i32,

    /// CDMA registration zone (RZ).
    registration_zone: ?i32,

    /// CDMA system ID (SID).
    system_id: i32,

    pub const json_field_names = .{
        .base_lat = "BaseLat",
        .base_lng = "BaseLng",
        .base_station_id = "BaseStationId",
        .cdma_local_id = "CdmaLocalId",
        .cdma_nmr = "CdmaNmr",
        .network_id = "NetworkId",
        .pilot_power = "PilotPower",
        .registration_zone = "RegistrationZone",
        .system_id = "SystemId",
    };
};
