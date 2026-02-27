pub const AutoApprovedChangeType = enum {
    add_member,
    grant_receive_results_ability,
    revoke_receive_results_ability,

    pub const json_field_names = .{
        .add_member = "ADD_MEMBER",
        .grant_receive_results_ability = "GRANT_RECEIVE_RESULTS_ABILITY",
        .revoke_receive_results_ability = "REVOKE_RECEIVE_RESULTS_ABILITY",
    };
};
