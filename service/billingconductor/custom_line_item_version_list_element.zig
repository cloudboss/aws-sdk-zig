const ListCustomLineItemChargeDetails = @import("list_custom_line_item_charge_details.zig").ListCustomLineItemChargeDetails;
const ComputationRuleEnum = @import("computation_rule_enum.zig").ComputationRuleEnum;
const CurrencyCode = @import("currency_code.zig").CurrencyCode;
const PresentationObject = @import("presentation_object.zig").PresentationObject;

/// A representation of a custom line item version.
pub const CustomLineItemVersionListElement = struct {
    /// The Amazon Web Services account in which this custom line item will be
    /// applied to.
    account_id: ?[]const u8,

    /// A list of custom line item Amazon Resource Names (ARNs) to retrieve
    /// information.
    arn: ?[]const u8,

    /// The number of resources that are associated with the custom line item.
    association_size: i64 = 0,

    /// The Amazon Resource Name (ARN) of the billing group that the custom line
    /// item applies to.
    billing_group_arn: ?[]const u8,

    charge_details: ?ListCustomLineItemChargeDetails,

    /// The computation rule for a specific version of a custom line item,
    /// determining how charges are computed and reflected in the bill.
    computation_rule: ?ComputationRuleEnum,

    /// The time when the custom line item version was created.
    creation_time: i64 = 0,

    /// The charge value currency of the custom line item.
    currency_code: ?CurrencyCode,

    /// The description of the custom line item.
    description: ?[]const u8,

    /// The end billing period of the custom line item version.
    end_billing_period: ?[]const u8,

    /// The most recent time that the custom line item version was modified.
    last_modified_time: i64 = 0,

    /// The name of the custom line item.
    name: ?[]const u8,

    /// Presentation configuration for a specific version of a custom line item,
    /// specifying how charges are displayed in the bill.
    presentation_details: ?PresentationObject,

    /// The product code that’s associated with the custom line item.
    product_code: ?[]const u8,

    /// The start billing period of the custom line item version.
    start_billing_period: ?[]const u8,

    /// The inclusive start time.
    start_time: i64 = 0,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .arn = "Arn",
        .association_size = "AssociationSize",
        .billing_group_arn = "BillingGroupArn",
        .charge_details = "ChargeDetails",
        .computation_rule = "ComputationRule",
        .creation_time = "CreationTime",
        .currency_code = "CurrencyCode",
        .description = "Description",
        .end_billing_period = "EndBillingPeriod",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .presentation_details = "PresentationDetails",
        .product_code = "ProductCode",
        .start_billing_period = "StartBillingPeriod",
        .start_time = "StartTime",
    };
};
