pub const SpeakerStatus = enum {
    enrolled,
    expired,
    opted_out,
    pending,

    pub const json_field_names = .{
        .enrolled = "ENROLLED",
        .expired = "EXPIRED",
        .opted_out = "OPTED_OUT",
        .pending = "PENDING",
    };
};
