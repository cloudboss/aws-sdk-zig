const IntendedUse = @import("intended_use.zig").IntendedUse;

/// Specifies the data storage option chosen for requesting Places.
///
/// When using Amazon Location Places:
///
/// * If using HERE Technologies as a data provider, you can't store results for
///   locations in Japan by setting `IntendedUse` to `Storage`. parameter.
/// * Under the `MobileAssetTracking` or `MobilAssetManagement` pricing plan,
///   you can't store results from your place index resources by setting
///   `IntendedUse` to `Storage`. This returns a validation exception error.
///
/// For more information, see the [AWS Service
/// Terms](https://aws.amazon.com/service-terms/) for Amazon Location Service.
pub const DataSourceConfiguration = struct {
    /// Specifies how the results of an operation will be stored by the caller.
    ///
    /// Valid values include:
    ///
    /// * `SingleUse` specifies that the results won't be stored.
    /// * `Storage` specifies that the result can be cached or stored in a database.
    ///
    /// Default value: `SingleUse`
    intended_use: ?IntendedUse,

    pub const json_field_names = .{
        .intended_use = "IntendedUse",
    };
};
