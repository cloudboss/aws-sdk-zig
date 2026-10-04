const std = @import("std");

pub const ChangeType = enum {
    add_member,
    grant_receive_results_ability,
    revoke_receive_results_ability,
    edit_auto_approved_change_types,
    add_payer_candidate,
    remove_payer_candidate,
    grant_can_receive_model_output,
    grant_can_receive_inference_output,
    revoke_can_receive_model_output,
    revoke_can_receive_inference_output,
    grant_export_query_analysis_log_ability,
    revoke_export_query_analysis_log_ability,

    pub const json_field_names = .{
        .add_member = "ADD_MEMBER",
        .grant_receive_results_ability = "GRANT_RECEIVE_RESULTS_ABILITY",
        .revoke_receive_results_ability = "REVOKE_RECEIVE_RESULTS_ABILITY",
        .edit_auto_approved_change_types = "EDIT_AUTO_APPROVED_CHANGE_TYPES",
        .add_payer_candidate = "ADD_PAYER_CANDIDATE",
        .remove_payer_candidate = "REMOVE_PAYER_CANDIDATE",
        .grant_can_receive_model_output = "GRANT_CAN_RECEIVE_MODEL_OUTPUT",
        .grant_can_receive_inference_output = "GRANT_CAN_RECEIVE_INFERENCE_OUTPUT",
        .revoke_can_receive_model_output = "REVOKE_CAN_RECEIVE_MODEL_OUTPUT",
        .revoke_can_receive_inference_output = "REVOKE_CAN_RECEIVE_INFERENCE_OUTPUT",
        .grant_export_query_analysis_log_ability = "GRANT_EXPORT_QUERY_ANALYSIS_LOG_ABILITY",
        .revoke_export_query_analysis_log_ability = "REVOKE_EXPORT_QUERY_ANALYSIS_LOG_ABILITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .add_member => "ADD_MEMBER",
            .grant_receive_results_ability => "GRANT_RECEIVE_RESULTS_ABILITY",
            .revoke_receive_results_ability => "REVOKE_RECEIVE_RESULTS_ABILITY",
            .edit_auto_approved_change_types => "EDIT_AUTO_APPROVED_CHANGE_TYPES",
            .add_payer_candidate => "ADD_PAYER_CANDIDATE",
            .remove_payer_candidate => "REMOVE_PAYER_CANDIDATE",
            .grant_can_receive_model_output => "GRANT_CAN_RECEIVE_MODEL_OUTPUT",
            .grant_can_receive_inference_output => "GRANT_CAN_RECEIVE_INFERENCE_OUTPUT",
            .revoke_can_receive_model_output => "REVOKE_CAN_RECEIVE_MODEL_OUTPUT",
            .revoke_can_receive_inference_output => "REVOKE_CAN_RECEIVE_INFERENCE_OUTPUT",
            .grant_export_query_analysis_log_ability => "GRANT_EXPORT_QUERY_ANALYSIS_LOG_ABILITY",
            .revoke_export_query_analysis_log_ability => "REVOKE_EXPORT_QUERY_ANALYSIS_LOG_ABILITY",
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
