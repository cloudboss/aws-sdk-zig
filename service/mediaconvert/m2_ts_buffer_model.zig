/// Controls what buffer model to use for accurate interleaving. If set to
/// MULTIPLEX, use multiplex buffer model. If set to NONE, this can lead to
/// lower latency, but low-memory devices may not be able to play back the
/// stream without interruptions.
pub const M2tsBufferModel = enum {
    multiplex,
    none,

    pub const json_field_names = .{
        .multiplex = "MULTIPLEX",
        .none = "NONE",
    };
};
