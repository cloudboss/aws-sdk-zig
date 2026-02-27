/// When set to WHEN_POSSIBLE, input DD+ audio will be passed through if it is
/// present on the input. this detection is dynamic over the life of the
/// transcode. Inputs that alternate between DD+ and non-DD+ content will have a
/// consistent DD+ output as the system alternates between passthrough and
/// encoding.
pub const Eac3PassthroughControl = enum {
    when_possible,
    no_passthrough,

    pub const json_field_names = .{
        .when_possible = "WHEN_POSSIBLE",
        .no_passthrough = "NO_PASSTHROUGH",
    };
};
