/// The configuration settings for the ID mapping table.
pub const IdMappingConfig = struct {
    /// An indicator as to whether you can use your column as a dimension column in
    /// the ID mapping table (`TRUE`) or not (`FALSE`).
    ///
    /// Default is `FALSE`.
    allow_use_as_dimension_column: bool = false,

    pub const json_field_names = .{
        .allow_use_as_dimension_column = "allowUseAsDimensionColumn",
    };
};
