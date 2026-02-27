pub const FilterField = enum {
    action_name,
    approval_team_name,
    voting_time,
    vote,
    session_status,
    initiation_time,

    pub const json_field_names = .{
        .action_name = "ACTION_NAME",
        .approval_team_name = "APPROVAL_TEAM_NAME",
        .voting_time = "VOTING_TIME",
        .vote = "VOTE",
        .session_status = "SESSION_STATUS",
        .initiation_time = "INITIATION_TIME",
    };
};
