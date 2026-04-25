/// Details about an available extension offering for a training plan. Use the
/// offering ID with the `
/// [ExtendTrainingPlan](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_ExtendTrainingPlan.html) ` API to extend a training plan.
pub const TrainingPlanExtensionOffering = struct {
    /// The Availability Zone for this extension offering.
    availability_zone: ?[]const u8 = null,

    /// The currency code for the upfront fee (e.g., USD).
    currency_code: ?[]const u8 = null,

    /// The duration of this extension offering in hours.
    duration_hours: ?i32 = null,

    /// The end date of this extension offering.
    end_date: ?i64 = null,

    /// The start date of this extension offering.
    start_date: ?i64 = null,

    /// The unique identifier for this extension offering.
    training_plan_extension_offering_id: []const u8,

    /// The upfront fee for this extension offering.
    upfront_fee: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .currency_code = "CurrencyCode",
        .duration_hours = "DurationHours",
        .end_date = "EndDate",
        .start_date = "StartDate",
        .training_plan_extension_offering_id = "TrainingPlanExtensionOfferingId",
        .upfront_fee = "UpfrontFee",
    };
};
