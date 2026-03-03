/// A summary report of actual Amazon Web Services charges and calculated Amazon
/// Web Services charges, based on the associated pricing plan of a billing
/// group.
pub const BillingGroupCostReportElement = struct {
    /// The Amazon Resource Name (ARN) of a billing group.
    arn: ?[]const u8 = null,

    /// The actual Amazon Web Services charges for the billing group.
    aws_cost: ?[]const u8 = null,

    /// The displayed currency.
    currency: ?[]const u8 = null,

    /// The billing group margin.
    margin: ?[]const u8 = null,

    /// The percentage of billing group margin.
    margin_percentage: ?[]const u8 = null,

    /// The hypothetical Amazon Web Services charges based on the associated pricing
    /// plan of a billing group.
    proforma_cost: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .aws_cost = "AWSCost",
        .currency = "Currency",
        .margin = "Margin",
        .margin_percentage = "MarginPercentage",
        .proforma_cost = "ProformaCost",
    };
};
