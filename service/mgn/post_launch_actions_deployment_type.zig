pub const PostLaunchActionsDeploymentType = enum {
    test_and_cutover,
    cutover_only,
    test_only,

    pub const json_field_names = .{
        .test_and_cutover = "TEST_AND_CUTOVER",
        .cutover_only = "CUTOVER_ONLY",
        .test_only = "TEST_ONLY",
    };
};
