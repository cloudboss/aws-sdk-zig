/// The key-value pair that represents the attribute by which the
/// `BillingGroupCostReportResults` are grouped. For example, if you want a
/// service-level breakdown for Amazon Simple Storage Service (Amazon S3) of the
/// billing group, the attribute will be a key-value pair of `"PRODUCT_NAME"`
/// and `"S3"`.
pub const Attribute = struct {
    /// The key in a key-value pair that describes the margin summary.
    key: ?[]const u8,

    /// The value in a key-value pair that describes the margin summary.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
