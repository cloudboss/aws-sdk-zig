/// Type of topic in a policy
pub const GuardrailTopicType = enum {
    deny,

    pub const json_field_names = .{
        .deny = "DENY",
    };
};
