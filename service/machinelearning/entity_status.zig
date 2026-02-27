/// Object status with the following possible values:
///
/// * `PENDING`
///
/// * `INPROGRESS`
///
/// * `FAILED`
///
/// * `COMPLETED`
///
/// * `DELETED`
pub const EntityStatus = enum {
    pending,
    inprogress,
    failed,
    completed,
    deleted,

    pub const json_field_names = .{
        .pending = "PENDING",
        .inprogress = "INPROGRESS",
        .failed = "FAILED",
        .completed = "COMPLETED",
        .deleted = "DELETED",
    };
};
