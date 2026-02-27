/// The length of the term of your reserved queue pricing plan commitment.
pub const Commitment = enum {
    one_year,

    pub const json_field_names = .{
        .one_year = "ONE_YEAR",
    };
};
