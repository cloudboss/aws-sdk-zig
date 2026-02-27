pub const ReviewPolicyLevel = enum {
    assignment,
    hit,

    pub const json_field_names = .{
        .assignment = "Assignment",
        .hit = "HIT",
    };
};
