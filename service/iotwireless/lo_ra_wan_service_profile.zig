/// LoRaWANServiceProfile object.
pub const LoRaWANServiceProfile = struct {
    /// The AddGWMetaData value.
    add_gw_metadata: bool = false,

    /// The DrMax value.
    dr_max: ?i32,

    /// The DrMin value.
    dr_min: ?i32,

    /// The maximum number of transmissions.
    ///
    /// Default: `3`
    nb_trans_max: ?i32,

    /// The minimum number of transmissions.
    ///
    /// Default: `0`
    nb_trans_min: ?i32,

    /// The PRAllowed value that describes whether passive roaming is allowed.
    pr_allowed: bool = false,

    /// The RAAllowed value that describes whether roaming activation is allowed.
    ra_allowed: bool = false,

    /// The Transmit Power Index maximum.
    ///
    /// Default: `15`
    tx_power_index_max: ?i32,

    /// The Transmit Power Index minimum.
    ///
    /// Default: `0`
    tx_power_index_min: ?i32,

    pub const json_field_names = .{
        .add_gw_metadata = "AddGwMetadata",
        .dr_max = "DrMax",
        .dr_min = "DrMin",
        .nb_trans_max = "NbTransMax",
        .nb_trans_min = "NbTransMin",
        .pr_allowed = "PrAllowed",
        .ra_allowed = "RaAllowed",
        .tx_power_index_max = "TxPowerIndexMax",
        .tx_power_index_min = "TxPowerIndexMin",
    };
};
