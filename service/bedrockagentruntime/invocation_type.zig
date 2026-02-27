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
};
