/// Formatting options for a VCF file.
pub const VcfOptions = struct {
    /// The file's ignore filter field setting.
    ignore_filter_field: ?bool = null,

    /// The file's ignore qual field setting.
    ignore_qual_field: ?bool = null,

    pub const json_field_names = .{
        .ignore_filter_field = "ignoreFilterField",
        .ignore_qual_field = "ignoreQualField",
    };
};
