/// The OpsItem data type to return.
pub const OpsResultAttribute = struct {
    /// Name of the data type. Valid value: `AWS:OpsItem`,
    /// `AWS:EC2InstanceInformation`, `AWS:OpsItemTrendline`, or
    /// `AWS:ComplianceSummary`.
    type_name: []const u8,

    pub const json_field_names = .{
        .type_name = "TypeName",
    };
};
