/// The filter used to retrieve specific `BillingGroupCostReportElements`.
pub const ListBillingGroupCostReportsFilter = struct {
    /// The list of Amazon Resource Names (ARNs) used to filter billing groups to
    /// retrieve reports.
    billing_group_arns: ?[]const []const u8,

    pub const json_field_names = .{
        .billing_group_arns = "BillingGroupArns",
    };
};
