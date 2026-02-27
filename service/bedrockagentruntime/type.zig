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
};
