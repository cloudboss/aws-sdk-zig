/// Configuration controlling whether MSK creates the destination Apache Iceberg
/// table if it does not already exist.
pub const TableCreation = struct {
    /// Whether MSK creates the destination table on the customer's behalf. Must be
    /// true for the current release.
    enable_table_creation: ?bool = null,

    pub const json_field_names = .{
        .enable_table_creation = "EnableTableCreation",
    };
};
