pub const ConnectionTestingMethod = enum {
    prod_env_dollar_test,
    test_env_replay_test,

    pub const json_field_names = .{
        .prod_env_dollar_test = "PROD_ENV_DOLLAR_TEST",
        .test_env_replay_test = "TEST_ENV_REPLAY_TEST",
    };
};
