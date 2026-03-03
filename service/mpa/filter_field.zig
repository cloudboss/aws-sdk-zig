const std = @import("std");

pub const FilterField = enum {
    action_name,
    approval_team_name,
    voting_time,
    vote,
    session_status,
    initiation_time,

    pub const json_field_names = .{
        .action_name = "ActionName",
        .approval_team_name = "ApprovalTeamName",
        .voting_time = "VotingTime",
        .vote = "Vote",
        .session_status = "SessionStatus",
        .initiation_time = "InitiationTime",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .action_name => "ActionName",
            .approval_team_name => "ApprovalTeamName",
            .voting_time => "VotingTime",
            .vote => "Vote",
            .session_status => "SessionStatus",
            .initiation_time => "InitiationTime",
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
