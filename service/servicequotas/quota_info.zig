/// Information on your Service Quotas for [Service Quotas Automatic
/// Management](https://docs.aws.amazon.com/servicequotas/latest/userguide/automatic-management.html). Automatic Management monitors your Service Quotas utilization and notifies you before you
/// run out of your allocated quotas.
pub const QuotaInfo = struct {
    /// The Service Quotas code for the Amazon Web Services service monitored with
    /// Automatic Management.
    quota_code: ?[]const u8,

    /// The Service Quotas name for the Amazon Web Services service monitored with
    /// Automatic Management.
    quota_name: ?[]const u8,

    pub const json_field_names = .{
        .quota_code = "QuotaCode",
        .quota_name = "QuotaName",
    };
};
