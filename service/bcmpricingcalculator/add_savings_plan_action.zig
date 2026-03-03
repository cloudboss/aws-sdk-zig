/// Represents an action to add a Savings Plan to a bill scenario.
pub const AddSavingsPlanAction = struct {
    /// The hourly commitment, in the same currency of the `savingsPlanOfferingId`.
    /// This is a value between 0.001 and 1 million. You cannot specify more than
    /// five digits after the decimal point.
    commitment: ?f64 = null,

    /// The ID of the Savings Plan offering to add. For more information, see [
    /// DescribeSavingsPlansOfferings](https://docs.aws.amazon.com/savingsplans/latest/APIReference/API_DescribeSavingsPlansOfferings.html).
    savings_plan_offering_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .commitment = "commitment",
        .savings_plan_offering_id = "savingsPlanOfferingId",
    };
};
