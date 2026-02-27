/// The readiness status.
pub const Readiness = enum {
    ready,
    not_ready,
    unknown,
    not_authorized,

    pub const json_field_names = .{
        .ready = "READY",
        .not_ready = "NOT_READY",
        .unknown = "UNKNOWN",
        .not_authorized = "NOT_AUTHORIZED",
    };
};
