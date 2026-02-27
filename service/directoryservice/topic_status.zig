pub const TopicStatus = enum {
    registered,
    topic_not_found,
    failed,
    deleted,

    pub const json_field_names = .{
        .registered = "REGISTERED",
        .topic_not_found = "TOPIC_NOT_FOUND",
        .failed = "FAILED",
        .deleted = "DELETED",
    };
};
