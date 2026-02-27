/// The configuration to enable schema evolution.
///
/// Amazon Data Firehose is in preview release and is subject to change.
pub const SchemaEvolutionConfiguration = struct {
    /// Specify whether you want to enable schema evolution.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    enabled: bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
