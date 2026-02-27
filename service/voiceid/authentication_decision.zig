pub const AuthenticationDecision = enum {
    accept,
    reject,
    not_enough_speech,
    speaker_not_enrolled,
    speaker_opted_out,
    speaker_id_not_provided,
    speaker_expired,

    pub const json_field_names = .{
        .accept = "ACCEPT",
        .reject = "REJECT",
        .not_enough_speech = "NOT_ENOUGH_SPEECH",
        .speaker_not_enrolled = "SPEAKER_NOT_ENROLLED",
        .speaker_opted_out = "SPEAKER_OPTED_OUT",
        .speaker_id_not_provided = "SPEAKER_ID_NOT_PROVIDED",
        .speaker_expired = "SPEAKER_EXPIRED",
    };
};
