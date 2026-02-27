pub const GitPullRequestEventType = enum {
    open,
    updated,
    closed,

    pub const json_field_names = .{
        .open = "OPEN",
        .updated = "UPDATED",
        .closed = "CLOSED",
    };
};
