pub const ContactRecordingType = enum {
    agent,
    ivr,
    screen,

    pub const json_field_names = .{
        .agent = "AGENT",
        .ivr = "IVR",
        .screen = "SCREEN",
    };
};
