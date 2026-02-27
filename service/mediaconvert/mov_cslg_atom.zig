/// When enabled, file composition times will start at zero, composition times
/// in the 'ctts' (composition time to sample) box for B-frames will be
/// negative, and a 'cslg' (composition shift least greatest) box will be
/// included per 14496-1 amendment 1. This improves compatibility with Apple
/// players and tools.
pub const MovCslgAtom = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };
};
