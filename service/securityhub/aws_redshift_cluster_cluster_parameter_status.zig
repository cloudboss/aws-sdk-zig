/// The status of a parameter in a cluster parameter group for an Amazon
/// Redshift
/// cluster.
pub const AwsRedshiftClusterClusterParameterStatus = struct {
    /// The error that prevented the parameter from being applied to the database.
    parameter_apply_error_description: ?[]const u8 = null,

    /// The status of the parameter. Indicates whether the parameter is in sync with
    /// the
    /// database, waiting for a cluster reboot, or encountered an error when it was
    /// applied.
    ///
    /// Valid values: `in-sync` | `pending-reboot` | `applying`
    /// | `invalid-parameter` | `apply-deferred` | `apply-error` |
    /// `unknown-error`
    parameter_apply_status: ?[]const u8 = null,

    /// The name of the parameter.
    parameter_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .parameter_apply_error_description = "ParameterApplyErrorDescription",
        .parameter_apply_status = "ParameterApplyStatus",
        .parameter_name = "ParameterName",
    };
};
