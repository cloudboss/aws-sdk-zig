/// The configuration to enable automatic table creation.
///
/// Amazon Data Firehose is in preview release and is subject to change.
pub const TableCreationConfiguration = struct {
    /// Specify whether you want to enable automatic table creation.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    enabled: bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
