/// Represents the JSON-specific options that define how input is to be
/// interpreted by Glue DataBrew.
pub const JsonOptions = struct {
    /// A value that specifies whether JSON input contains embedded new line
    /// characters.
    multi_line: bool = false,

    pub const json_field_names = .{
        .multi_line = "MultiLine",
    };
};
