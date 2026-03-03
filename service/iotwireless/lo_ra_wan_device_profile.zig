/// LoRaWANDeviceProfile object.
pub const LoRaWANDeviceProfile = struct {
    /// The ClassBTimeout value.
    class_b_timeout: ?i32 = null,

    /// The ClassCTimeout value.
    class_c_timeout: ?i32 = null,

    /// The list of values that make up the FactoryPresetFreqs value.
    factory_preset_freqs_list: ?[]const i32 = null,

    /// The MAC version (such as OTAA 1.1 or OTAA 1.0.3) to use with this device
    /// profile.
    mac_version: ?[]const u8 = null,

    /// The MaxDutyCycle value. It ranges from 0 to 15.
    max_duty_cycle: ?i32 = null,

    /// The MaxEIRP value.
    max_eirp: ?i32 = null,

    /// The PingSlotDR value.
    ping_slot_dr: ?i32 = null,

    /// The PingSlotFreq value.
    ping_slot_freq: ?i32 = null,

    /// The PingSlotPeriod value.
    ping_slot_period: ?i32 = null,

    /// The version of regional parameters.
    reg_params_revision: ?[]const u8 = null,

    /// The frequency band (RFRegion) value.
    rf_region: ?[]const u8 = null,

    /// The RXDataRate2 value.
    rx_data_rate_2: ?i32 = null,

    /// The RXDelay1 value.
    rx_delay_1: ?i32 = null,

    /// The RXDROffset1 value.
    rx_dr_offset_1: ?i32 = null,

    /// The RXFreq2 value.
    rx_freq_2: ?i32 = null,

    /// The Supports32BitFCnt value.
    supports_32_bit_f_cnt: bool = false,

    /// The SupportsClassB value.
    supports_class_b: bool = false,

    /// The SupportsClassC value.
    supports_class_c: bool = false,

    /// The SupportsJoin value.
    supports_join: ?bool = null,

    pub const json_field_names = .{
        .class_b_timeout = "ClassBTimeout",
        .class_c_timeout = "ClassCTimeout",
        .factory_preset_freqs_list = "FactoryPresetFreqsList",
        .mac_version = "MacVersion",
        .max_duty_cycle = "MaxDutyCycle",
        .max_eirp = "MaxEirp",
        .ping_slot_dr = "PingSlotDr",
        .ping_slot_freq = "PingSlotFreq",
        .ping_slot_period = "PingSlotPeriod",
        .reg_params_revision = "RegParamsRevision",
        .rf_region = "RfRegion",
        .rx_data_rate_2 = "RxDataRate2",
        .rx_delay_1 = "RxDelay1",
        .rx_dr_offset_1 = "RxDrOffset1",
        .rx_freq_2 = "RxFreq2",
        .supports_32_bit_f_cnt = "Supports32BitFCnt",
        .supports_class_b = "SupportsClassB",
        .supports_class_c = "SupportsClassC",
        .supports_join = "SupportsJoin",
    };
};
