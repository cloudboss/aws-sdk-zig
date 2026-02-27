/// Describes a link application log sample.
pub const LinkApplicationLogSampling = struct {
    /// An error log entry.
    error_log: f64,

    /// A filter log entry.
    filter_log: f64,

    pub const json_field_names = .{
        .error_log = "errorLog",
        .filter_log = "filterLog",
    };
};
