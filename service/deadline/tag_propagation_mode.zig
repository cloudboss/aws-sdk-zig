pub const TagPropagationMode = enum {
    no_propagation,
    propagate_tags_to_workers_at_launch,

    pub const json_field_names = .{
        .no_propagation = "NO_PROPAGATION",
        .propagate_tags_to_workers_at_launch = "PROPAGATE_TAGS_TO_WORKERS_AT_LAUNCH",
    };
};
