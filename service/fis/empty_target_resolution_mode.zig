pub const EmptyTargetResolutionMode = enum {
    fail,
    skip,

    pub const json_field_names = .{
        .fail = "FAIL",
        .skip = "SKIP",
    };
};
