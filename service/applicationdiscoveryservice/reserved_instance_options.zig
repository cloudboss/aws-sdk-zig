const OfferingClass = @import("offering_class.zig").OfferingClass;
const PurchasingOption = @import("purchasing_option.zig").PurchasingOption;
const TermLength = @import("term_length.zig").TermLength;

/// Used to provide Reserved Instance preferences for the recommendation.
pub const ReservedInstanceOptions = struct {
    /// The flexibility to change the instance types needed for your Reserved
    /// Instance.
    offering_class: OfferingClass,

    /// The payment plan to use for your Reserved Instance.
    purchasing_option: PurchasingOption,

    /// The preferred duration of the Reserved Instance term.
    term_length: TermLength,

    pub const json_field_names = .{
        .offering_class = "offeringClass",
        .purchasing_option = "purchasingOption",
        .term_length = "termLength",
    };
};
