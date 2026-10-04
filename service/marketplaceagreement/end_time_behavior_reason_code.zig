const std = @import("std");

pub const EndTimeBehaviorReasonCode = enum {
    proposer_renew_opted_out,
    acceptor_renew_opted_out,
    no_renewal_term,
    renewal_limit_exhausted,

    pub const json_field_names = .{
        .proposer_renew_opted_out = "PROPOSER_RENEW_OPTED_OUT",
        .acceptor_renew_opted_out = "ACCEPTOR_RENEW_OPTED_OUT",
        .no_renewal_term = "NO_RENEWAL_TERM",
        .renewal_limit_exhausted = "RENEWAL_LIMIT_EXHAUSTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .proposer_renew_opted_out => "PROPOSER_RENEW_OPTED_OUT",
            .acceptor_renew_opted_out => "ACCEPTOR_RENEW_OPTED_OUT",
            .no_renewal_term => "NO_RENEWAL_TERM",
            .renewal_limit_exhausted => "RENEWAL_LIMIT_EXHAUSTED",
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
