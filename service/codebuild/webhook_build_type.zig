pub const WebhookBuildType = enum {
    build,
    build_batch,
    runner_buildkite_build,

    pub const json_field_names = .{
        .build = "BUILD",
        .build_batch = "BUILD_BATCH",
        .runner_buildkite_build = "RUNNER_BUILDKITE_BUILD",
    };
};
