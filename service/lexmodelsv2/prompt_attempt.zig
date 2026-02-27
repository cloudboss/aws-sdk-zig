/// The attempt name of attempts of a prompt.
pub const PromptAttempt = enum {
    initial,
    retry_1,
    retry_2,
    retry_3,
    retry_4,
    retry_5,

    pub const json_field_names = .{
        .initial = "Initial",
        .retry_1 = "Retry1",
        .retry_2 = "Retry2",
        .retry_3 = "Retry3",
        .retry_4 = "Retry4",
        .retry_5 = "Retry5",
    };
};
