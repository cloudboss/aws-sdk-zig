const std = @import("std");

pub const InvocationType = enum {
    action_group,
    knowledge_base,
    finish,
    action_group_code_interpreter,
    agent_collaborator,

    pub const json_field_names = .{
        .action_group = "ACTION_GROUP",
        .knowledge_base = "KNOWLEDGE_BASE",
        .finish = "FINISH",
        .action_group_code_interpreter = "ACTION_GROUP_CODE_INTERPRETER",
        .agent_collaborator = "AGENT_COLLABORATOR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .action_group => "ACTION_GROUP",
            .knowledge_base => "KNOWLEDGE_BASE",
            .finish => "FINISH",
            .action_group_code_interpreter => "ACTION_GROUP_CODE_INTERPRETER",
            .agent_collaborator => "AGENT_COLLABORATOR",
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
