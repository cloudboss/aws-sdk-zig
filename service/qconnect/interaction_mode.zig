const std = @import("std");

/// How an orchestrator agent engaged a collaborator agent.
///
/// * `DELEGATE` indicates that the orchestrator invoked the collaborator agent
///   and retained control of the conversation, resuming when the collaborator
///   returns.
/// * `HANDOFF` indicates that the orchestrator transferred control of the
///   conversation to the collaborator agent.
pub const InteractionMode = enum {
    delegate,
    handoff,

    pub const json_field_names = .{
        .delegate = "DELEGATE",
        .handoff = "HANDOFF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .delegate => "DELEGATE",
            .handoff => "HANDOFF",
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
