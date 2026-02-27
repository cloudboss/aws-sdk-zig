/// Actions that can performed on a contact by an agent
pub const AgentAction = enum {
    discard,

    pub const json_field_names = .{
        .discard = "DISCARD",
    };
};
