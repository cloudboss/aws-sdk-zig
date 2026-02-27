const Attribute = @import("attribute.zig").Attribute;

/// A paginated call to retrieve a list of summary reports of actual Amazon Web
/// Services charges and the calculated Amazon Web Services charges, broken down
/// by attributes.
pub const BillingGroupCostReportResultElement = struct {
    /// The Amazon Resource Number (ARN) that uniquely identifies the billing group.
    arn: ?[]const u8,

    /// The list of key-value pairs that represent the attributes by which the
    /// `BillingGroupCostReportResults` are grouped. For example, if you want the
    /// Amazon S3 service-level breakdown of a billing group for November 2023, the
    /// attributes list will contain a key-value pair of `"PRODUCT_NAME"` and `"S3"`
    /// and a key-value pair of `"BILLING_PERIOD"` and `"Nov 2023"`.
    attributes: ?[]const Attribute,

    /// The actual Amazon Web Services charges for the billing group.
    aws_cost: ?[]const u8,

    /// The displayed currency.
    currency: ?[]const u8,

    /// The billing group margin.
    margin: ?[]const u8,

    /// The percentage of the billing group margin.
    margin_percentage: ?[]const u8,

    /// The hypothetical Amazon Web Services charges based on the associated pricing
    /// plan of a billing group.
    proforma_cost: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .attributes = "Attributes",
        .aws_cost = "AWSCost",
        .currency = "Currency",
        .margin = "Margin",
        .margin_percentage = "MarginPercentage",
        .proforma_cost = "ProformaCost",
    };
};
