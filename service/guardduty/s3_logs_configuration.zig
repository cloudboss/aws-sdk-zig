/// Describes whether S3 data event logs will be enabled as a data source.
pub const S3LogsConfiguration = struct {
    /// The status of S3 data event logs as a data source.
    enable: bool,

    pub const json_field_names = .{
        .enable = "Enable",
    };
};
