const std = @import("std");

pub const ConnectionTestingMethod = enum {
    prod_env_dollar_test,
    test_env_replay_test,

    pub const json_field_names = .{
        .prod_env_dollar_test = "PROD_ENV_DOLLAR_TEST",
        .test_env_replay_test = "TEST_ENV_REPLAY_TEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .prod_env_dollar_test => "PROD_ENV_DOLLAR_TEST",
            .test_env_replay_test => "TEST_ENV_REPLAY_TEST",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
