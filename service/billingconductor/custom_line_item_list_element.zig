const ListCustomLineItemChargeDetails = @import("list_custom_line_item_charge_details.zig").ListCustomLineItemChargeDetails;
const ComputationRuleEnum = @import("computation_rule_enum.zig").ComputationRuleEnum;
const CurrencyCode = @import("currency_code.zig").CurrencyCode;
const PresentationObject = @import("presentation_object.zig").PresentationObject;

/// A representation of a custom line item.
pub const CustomLineItemListElement = struct {
    /// The Amazon Web Services account in which this custom line item will be
    /// applied to.
    account_id: ?[]const u8,

    /// The Amazon Resource Names (ARNs) for custom line items.
    arn: ?[]const u8,

    /// The number of resources that are associated to the custom line item.
    association_size: i64 = 0,

    /// The Amazon Resource Name (ARN) that references the billing group where the
    /// custom line item applies to.
    billing_group_arn: ?[]const u8,

    /// A `ListCustomLineItemChargeDetails` that describes the charge details of a
    /// custom line item.
    charge_details: ?ListCustomLineItemChargeDetails,

    /// The computation rule that determines how the custom line item charges are
    /// computed and reflected in the bill.
    computation_rule: ?ComputationRuleEnum,

    /// The time created.
    creation_time: i64 = 0,

    /// The custom line item's charge value currency. Only one of the valid values
    /// can be used.
    currency_code: ?CurrencyCode,

    /// The custom line item's description. This is shown on the Bills page in
    /// association with the charge value.
    description: ?[]const u8,

    /// The most recent time when the custom line item was modified.
    last_modified_time: i64 = 0,

    /// The custom line item's name.
    name: ?[]const u8,

    /// Configuration details specifying how the custom line item charges are
    /// presented, including which service the charges are shown under.
    presentation_details: ?PresentationObject,

    /// The product code that's associated with the custom line item.
    product_code: ?[]const u8,

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
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .presentation_details = "PresentationDetails",
        .product_code = "ProductCode",
    };
};
