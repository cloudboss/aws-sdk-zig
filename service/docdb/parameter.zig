const ApplyMethod = @import("apply_method.zig").ApplyMethod;

/// Detailed information about an individual parameter.
pub const Parameter = struct {
    /// Specifies the valid range of values for the parameter.
    allowed_values: ?[]const u8 = null,

    /// Indicates when to apply parameter updates.
    apply_method: ?ApplyMethod = null,

    /// Specifies the engine-specific parameters type.
    apply_type: ?[]const u8 = null,

    /// Specifies the valid data type for the parameter.
    data_type: ?[]const u8 = null,

    /// Provides a description of the parameter.
    description: ?[]const u8 = null,

    /// Indicates whether (`true`) or not (`false`) the parameter can
    /// be modified. Some parameters have security or operational implications that
    /// prevent them
    /// from being changed.
    is_modifiable: ?bool = null,

    /// The earliest engine version to which the parameter can apply.
    minimum_engine_version: ?[]const u8 = null,

    /// Specifies the name of the parameter.
    parameter_name: ?[]const u8 = null,

    /// Specifies the value of the parameter.
    /// Must be one or more of the cluster parameter's `AllowedValues` in CSV
    /// format:
    ///
    /// Valid values are:
    ///
    /// * `enabled`: The cluster accepts secure connections using TLS version 1.0
    ///   through 1.3.
    ///
    /// * `disabled`: The cluster does not accept secure connections using TLS.
    ///
    /// * `fips-140-3`: The cluster only accepts secure connections per the
    ///   requirements of the Federal Information Processing Standards (FIPS)
    ///   publication 140-3.
    /// Only supported starting with Amazon DocumentDB 5.0 (engine version 3.0.3727)
    /// clusters in these regions: ca-central-1, us-west-2, us-east-1, us-east-2,
    /// us-gov-east-1, us-gov-west-1.
    ///
    /// * `tls1.2+`: The cluster accepts secure connections using TLS version 1.2
    ///   and above.
    /// Only supported starting with Amazon DocumentDB 4.0 (engine version
    /// 2.0.10980) and Amazon DocumentDB 5.0 (engine version 3.0.11051).
    ///
    /// * `tls1.3+`: The cluster accepts secure connections using TLS version 1.3
    ///   and above.
    /// Only supported starting with Amazon DocumentDB 4.0 (engine version
    /// 2.0.10980) and Amazon DocumentDB 5.0 (engine version 3.0.11051).
    parameter_value: ?[]const u8 = null,

    /// Indicates the source of the parameter value.
    source: ?[]const u8 = null,
};
