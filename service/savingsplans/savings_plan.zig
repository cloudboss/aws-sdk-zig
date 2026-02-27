const aws = @import("aws");

const CurrencyCode = @import("currency_code.zig").CurrencyCode;
const SavingsPlanPaymentOption = @import("savings_plan_payment_option.zig").SavingsPlanPaymentOption;
const SavingsPlanProductType = @import("savings_plan_product_type.zig").SavingsPlanProductType;
const SavingsPlanType = @import("savings_plan_type.zig").SavingsPlanType;
const SavingsPlanState = @import("savings_plan_state.zig").SavingsPlanState;

/// Information about a Savings Plan.
pub const SavingsPlan = struct {
    /// The hourly commitment amount in the specified currency.
    commitment: ?[]const u8,

    /// The currency.
    currency: ?CurrencyCode,

    /// The description.
    description: ?[]const u8,

    /// The EC2 instance family.
    ec_2_instance_family: ?[]const u8,

    /// The end time.
    end: ?[]const u8,

    /// The ID of the offering.
    offering_id: ?[]const u8,

    /// The payment option.
    payment_option: ?SavingsPlanPaymentOption,

    /// The product types.
    product_types: ?[]const SavingsPlanProductType,

    /// The recurring payment amount.
    recurring_payment_amount: ?[]const u8,

    /// The Amazon Web Services Region.
    region: ?[]const u8,

    /// The time until when a return for the Savings Plan can be requested. If the
    /// Savings Plan is not returnable, the field reflects the Savings Plans start
    /// time.
    returnable_until: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the Savings Plan.
    savings_plan_arn: ?[]const u8,

    /// The ID of the Savings Plan.
    savings_plan_id: ?[]const u8,

    /// The plan type.
    savings_plan_type: ?SavingsPlanType,

    /// The start time.
    start: ?[]const u8,

    /// The current state.
    state: ?SavingsPlanState,

    /// One or more tags.
    tags: ?[]const aws.map.StringMapEntry,

    /// The duration of the term, in seconds.
    term_duration_in_seconds: i64 = 0,

    /// The up-front payment amount.
    upfront_payment_amount: ?[]const u8,

    pub const json_field_names = .{
        .commitment = "commitment",
        .currency = "currency",
        .description = "description",
        .ec_2_instance_family = "ec2InstanceFamily",
        .end = "end",
        .offering_id = "offeringId",
        .payment_option = "paymentOption",
        .product_types = "productTypes",
        .recurring_payment_amount = "recurringPaymentAmount",
        .region = "region",
        .returnable_until = "returnableUntil",
        .savings_plan_arn = "savingsPlanArn",
        .savings_plan_id = "savingsPlanId",
        .savings_plan_type = "savingsPlanType",
        .start = "start",
        .state = "state",
        .tags = "tags",
        .term_duration_in_seconds = "termDurationInSeconds",
        .upfront_payment_amount = "upfrontPaymentAmount",
    };
};
