pub const BillScenarioStatus = enum {
    ready,
    locked,
    failed,
    stale,

    pub const json_field_names = .{
        .ready = "READY",
        .locked = "LOCKED",
        .failed = "FAILED",
        .stale = "STALE",
    };
};
