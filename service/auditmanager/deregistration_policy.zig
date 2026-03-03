const DeleteResources = @import("delete_resources.zig").DeleteResources;

/// The deregistration policy for the data that's stored in Audit Manager. You
/// can
/// use this attribute to determine how your data is handled when you
/// [deregister Audit
/// Manager](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_DeregisterAccount.html).
///
/// By default, Audit Manager retains evidence data for two years from the time
/// of its
/// creation. Other Audit Manager resources (including assessments, custom
/// controls, and
/// custom frameworks) remain in Audit Manager indefinitely, and are available
/// if you
/// [re-register Audit
/// Manager](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_RegisterAccount.html) in the future. For more
/// information about data retention, see [Data
/// Protection](https://docs.aws.amazon.com/audit-manager/latest/userguide/data-protection.html) in the *Audit Manager User Guide*.
///
/// If you choose to delete all data, this action permanently deletes all
/// evidence data
/// in your account within seven days. It also deletes all of the Audit Manager
/// resources that you created, including assessments, custom controls, and
/// custom
/// frameworks. Your data will not be available if you re-register Audit Manager
/// in the
/// future.
pub const DeregistrationPolicy = struct {
    /// Specifies which Audit Manager data will be deleted when you deregister Audit
    /// Manager.
    ///
    /// * If you set the value to `ALL`, all of your data is deleted within seven
    /// days of deregistration.
    ///
    /// * If you set the value to `DEFAULT`, none of your data is deleted at the
    /// time of deregistration. However, keep in mind that the Audit Manager data
    /// retention policy still applies. As a result, any evidence data will be
    /// deleted two
    /// years after its creation date. Your other Audit Manager resources will
    /// continue
    /// to exist indefinitely.
    delete_resources: ?DeleteResources = null,

    pub const json_field_names = .{
        .delete_resources = "deleteResources",
    };
};
