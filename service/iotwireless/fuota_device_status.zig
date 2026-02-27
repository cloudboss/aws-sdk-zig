/// The status of a wireless device in a FUOTA task.
pub const FuotaDeviceStatus = enum {
    initial,
    package_not_supported,
    frag_algo_unsupported,
    not_enough_memory,
    frag_index_unsupported,
    wrong_descriptor,
    session_cnt_replay,
    missing_frag,
    memory_error,
    mic_error,
    successful,
    device_exist_in_conflict_fuota_task,

    pub const json_field_names = .{
        .initial = "Initial",
        .package_not_supported = "Package_Not_Supported",
        .frag_algo_unsupported = "FragAlgo_unsupported",
        .not_enough_memory = "Not_enough_memory",
        .frag_index_unsupported = "FragIndex_unsupported",
        .wrong_descriptor = "Wrong_descriptor",
        .session_cnt_replay = "SessionCnt_replay",
        .missing_frag = "MissingFrag",
        .memory_error = "MemoryError",
        .mic_error = "MICError",
        .successful = "Successful",
        .device_exist_in_conflict_fuota_task = "Device_exist_in_conflict_fuota_task",
    };
};
