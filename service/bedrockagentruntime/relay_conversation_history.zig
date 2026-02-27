pub const RelayConversationHistory = enum {
    to_collaborator,
    disabled,

    pub const json_field_names = .{
        .to_collaborator = "TO_COLLABORATOR",
        .disabled = "DISABLED",
    };
};
