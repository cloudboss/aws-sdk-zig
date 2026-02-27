/// Keep the default value unless you know that your audio EBP markers are
/// incorrectly appearing before your video EBP markers. To correct this
/// problem, set this value to Force.
pub const M2tsForceTsVideoEbpOrder = enum {
    force,
    default,

    pub const json_field_names = .{
        .force = "FORCE",
        .default = "DEFAULT",
    };
};
