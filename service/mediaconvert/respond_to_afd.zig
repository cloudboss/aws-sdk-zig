/// Use Respond to AFD to specify how the service changes the video itself in
/// response to AFD values in the input. * Choose Respond to clip the input
/// video frame according to the AFD value, input display aspect ratio, and
/// output display aspect ratio. * Choose Passthrough to include the input AFD
/// values. Do not choose this when AfdSignaling is set to NONE. A preferred
/// implementation of this workflow is to set RespondToAfd to and set
/// AfdSignaling to AUTO. * Choose None to remove all input AFD values from this
/// output.
pub const RespondToAfd = enum {
    none,
    respond,
    passthrough,

    pub const json_field_names = .{
        .none = "NONE",
        .respond = "RESPOND",
        .passthrough = "PASSTHROUGH",
    };
};
