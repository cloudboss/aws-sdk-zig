/// The sort order specified in a listing condition. Possible values include the
/// following:
///
/// * `asc` - Present the information in ascending order (from A-Z).
///
/// * `dsc` - Present the information in descending order (from Z-A).
pub const SortOrder = enum {
    asc,
    dsc,

    pub const json_field_names = .{
        .asc = "ASC",
        .dsc = "DSC",
    };
};
