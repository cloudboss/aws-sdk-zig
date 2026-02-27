pub const MemberAbility = enum {
    can_query,
    can_receive_results,
    can_run_job,

    pub const json_field_names = .{
        .can_query = "CAN_QUERY",
        .can_receive_results = "CAN_RECEIVE_RESULTS",
        .can_run_job = "CAN_RUN_JOB",
    };
};
