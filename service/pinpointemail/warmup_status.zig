/// The warmup status of a dedicated IP.
pub const WarmupStatus = enum {
    in_progress,
    done,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .done = "DONE",
    };
};
