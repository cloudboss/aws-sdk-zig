pub const RecommendationStatus = enum {
    implemented,
    inactive,
    not_implemented,
    excluded,

    pub const json_field_names = .{
        .implemented = "IMPLEMENTED",
        .inactive = "INACTIVE",
        .not_implemented = "NOT_IMPLEMENTED",
        .excluded = "EXCLUDED",
    };
};
