const std = @import("std");

pub const AutoApprovedChangeType = enum {
    add_member,
    grant_receive_results_ability,
    revoke_receive_results_ability,

    pub const json_field_names = .{
        .add_member = "ADD_MEMBER",
        .grant_receive_results_ability = "GRANT_RECEIVE_RESULTS_ABILITY",
        .revoke_receive_results_ability = "REVOKE_RECEIVE_RESULTS_ABILITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .add_member => "ADD_MEMBER",
            .grant_receive_results_ability => "GRANT_RECEIVE_RESULTS_ABILITY",
            .revoke_receive_results_ability => "REVOKE_RECEIVE_RESULTS_ABILITY",
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
