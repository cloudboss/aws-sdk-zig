/// Follow reference point.
pub const FollowPoint = enum {
    end,
    start,

    pub const json_field_names = .{
        .end = "END",
        .start = "START",
    };
};
