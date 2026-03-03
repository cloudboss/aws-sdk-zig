const LteLocalId = @import("lte_local_id.zig").LteLocalId;
const LteNetworkMeasurements = @import("lte_network_measurements.zig").LteNetworkMeasurements;

/// Details about the Long-Term Evolution (LTE) network.
pub const LteCellDetails = struct {
    /// The E-UTRAN Cell Identifier (ECI).
    cell_id: i32 = 0,

    /// The LTE local identification information (local ID).
    local_id: ?LteLocalId = null,

    /// The Mobile Country Code (MCC).
    mcc: i32,

    /// The Mobile Network Code (MNC)
    mnc: i32,

    /// The network measurements.
    network_measurements: ?[]const LteNetworkMeasurements = null,

    /// Indicates whether the LTE object is capable of supporting NR (new radio).
    nr_capable: ?bool = null,

    /// Signal power of the reference signal received, measured in
    /// decibel-milliwatts (dBm).
    rsrp: ?i32 = null,

    /// Signal quality of the reference Signal received, measured in decibels (dB).
    rsrq: ?f32 = null,

    /// LTE Tracking Area Code (TAC).
    tac: ?i32 = null,

    /// Timing Advance (TA).
    timing_advance: ?i32 = null,

    pub const json_field_names = .{
        .cell_id = "CellId",
        .local_id = "LocalId",
        .mcc = "Mcc",
        .mnc = "Mnc",
        .network_measurements = "NetworkMeasurements",
        .nr_capable = "NrCapable",
        .rsrp = "Rsrp",
        .rsrq = "Rsrq",
        .tac = "Tac",
        .timing_advance = "TimingAdvance",
    };
};
