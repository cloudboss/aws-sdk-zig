/// Represents a set of options that define how DataBrew will write a
/// comma-separated value (CSV) file.
pub const CsvOutputOptions = struct {
    /// A single character that specifies the delimiter used to create CSV job
    /// output.
    delimiter: ?[]const u8 = null,

    pub const json_field_names = .{
        .delimiter = "Delimiter",
    };
};
