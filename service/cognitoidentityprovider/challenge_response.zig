pub const ChallengeResponse = enum {
    success,
    failure,

    pub const json_field_names = .{
        .success = "Success",
        .failure = "Failure",
    };
};
