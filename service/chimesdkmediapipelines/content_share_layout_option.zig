pub const ContentShareLayoutOption = enum {
    presenter_only,
    horizontal,
    vertical,
    active_speaker_only,

    pub const json_field_names = .{
        .presenter_only = "PresenterOnly",
        .horizontal = "Horizontal",
        .vertical = "Vertical",
        .active_speaker_only = "ActiveSpeakerOnly",
    };
};
