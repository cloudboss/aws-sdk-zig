const std = @import("std");

/// The reason a sub-agent returned control to the calling agent.
///
/// * `COMPLETE` – the request was fulfilled.
/// * `COMPLETE_WITH_ERROR` – the sub-agent attempted the request but could not
///   fully complete it.
/// * `ESCALATE` – the conversation should be transferred to a human agent.
/// * `OUT_OF_DOMAIN` – the request fell outside the sub-agent's domain of
///   expertise.
pub const ReturnReason = enum {
    complete,
    complete_with_error,
    escalate,
    out_of_domain,

    pub const json_field_names = .{
        .complete = "COMPLETE",
        .complete_with_error = "COMPLETE_WITH_ERROR",
        .escalate = "ESCALATE",
        .out_of_domain = "OUT_OF_DOMAIN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .complete => "COMPLETE",
            .complete_with_error => "COMPLETE_WITH_ERROR",
            .escalate => "ESCALATE",
            .out_of_domain => "OUT_OF_DOMAIN",
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
