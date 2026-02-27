pub const ExclusionStatus = enum {
    excluded,
    included,

    pub const json_field_names = .{
        .excluded = "EXCLUDED",
        .included = "INCLUDED",
    };
};
