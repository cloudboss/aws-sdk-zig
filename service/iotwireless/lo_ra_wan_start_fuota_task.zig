/// The LoRaWAN information used to start a FUOTA task.
pub const LoRaWANStartFuotaTask = struct {
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .start_time = "StartTime",
    };
};
