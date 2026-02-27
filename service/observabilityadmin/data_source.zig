/// Information about a data source associated with the telemetry pipeline. For
/// CloudWatch Logs sources, this includes both a name and type extracted from
/// the log event metadata. For third-party sources (such as S3), this includes
/// only a name, with the type field left empty.
pub const DataSource = struct {
    /// The name of the data source. For CloudWatch Logs sources, this corresponds
    /// to the `data_source_name` from the log event metadata. For third-party
    /// sources, this is either the configured `data_source_name` or defaults to the
    /// plugin name if not specified.
    name: ?[]const u8,

    /// The type of the data source. For CloudWatch Logs sources, this corresponds
    /// to the `data_source_type` from the log event metadata. For third-party
    /// sources, this field is empty.
    type: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .type = "Type",
    };
};
