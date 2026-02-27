pub const ChangeType = enum {
    add_member,
    grant_receive_results_ability,
    revoke_receive_results_ability,
    edit_auto_approved_change_types,

    pub const json_field_names = .{
        .add_member = "ADD_MEMBER",
        .grant_receive_results_ability = "GRANT_RECEIVE_RESULTS_ABILITY",
        .revoke_receive_results_ability = "REVOKE_RECEIVE_RESULTS_ABILITY",
        .edit_auto_approved_change_types = "EDIT_AUTO_APPROVED_CHANGE_TYPES",
    };
};
