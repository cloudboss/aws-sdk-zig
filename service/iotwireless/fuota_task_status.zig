/// The status of a FUOTA task.
pub const FuotaTaskStatus = enum {
    pending,
    fuota_session_waiting,
    in_fuota_session,
    fuota_done,
    delete_waiting,

    pub const json_field_names = .{
        .pending = "Pending",
        .fuota_session_waiting = "FuotaSession_Waiting",
        .in_fuota_session = "In_FuotaSession",
        .fuota_done = "FuotaDone",
        .delete_waiting = "Delete_Waiting",
    };
};
