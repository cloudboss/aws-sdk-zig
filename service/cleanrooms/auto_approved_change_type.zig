const std = @import("std");

pub const AutoApprovedChangeType = enum {
    add_member,
    grant_receive_results_ability,
    revoke_receive_results_ability,
    grant_export_query_analysis_log_ability,
    revoke_export_query_analysis_log_ability,

    pub const json_field_names = .{
        .add_member = "ADD_MEMBER",
        .grant_receive_results_ability = "GRANT_RECEIVE_RESULTS_ABILITY",
        .revoke_receive_results_ability = "REVOKE_RECEIVE_RESULTS_ABILITY",
        .grant_export_query_analysis_log_ability = "GRANT_EXPORT_QUERY_ANALYSIS_LOG_ABILITY",
        .revoke_export_query_analysis_log_ability = "REVOKE_EXPORT_QUERY_ANALYSIS_LOG_ABILITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .add_member => "ADD_MEMBER",
            .grant_receive_results_ability => "GRANT_RECEIVE_RESULTS_ABILITY",
            .revoke_receive_results_ability => "REVOKE_RECEIVE_RESULTS_ABILITY",
            .grant_export_query_analysis_log_ability => "GRANT_EXPORT_QUERY_ANALYSIS_LOG_ABILITY",
            .revoke_export_query_analysis_log_ability => "REVOKE_EXPORT_QUERY_ANALYSIS_LOG_ABILITY",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
