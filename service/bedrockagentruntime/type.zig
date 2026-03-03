const std = @import("std");

pub const Type = enum {
    action_group,
    agent_collaborator,
    knowledge_base,
    finish,
    ask_user,
    reprompt,

    pub const json_field_names = .{
        .action_group = "ACTION_GROUP",
        .agent_collaborator = "AGENT_COLLABORATOR",
        .knowledge_base = "KNOWLEDGE_BASE",
        .finish = "FINISH",
        .ask_user = "ASK_USER",
        .reprompt = "REPROMPT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .action_group => "ACTION_GROUP",
            .agent_collaborator => "AGENT_COLLABORATOR",
            .knowledge_base => "KNOWLEDGE_BASE",
            .finish => "FINISH",
            .ask_user => "ASK_USER",
            .reprompt => "REPROMPT",
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
