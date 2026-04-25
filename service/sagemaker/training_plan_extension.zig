/// Details about an extension to a training plan, including the offering ID,
/// dates, status, and cost information.
pub const TrainingPlanExtension = struct {
    /// The Availability Zone of the extension.
    availability_zone: ?[]const u8 = null,

    /// The Availability Zone ID of the extension.
    availability_zone_id: ?[]const u8 = null,

    /// The currency code for the upfront fee (e.g., USD).
    currency_code: ?[]const u8 = null,

    /// The duration of the extension in hours.
    duration_hours: ?i32 = null,

    /// The end date of the extension period.
    end_date: ?i64 = null,

    /// The timestamp when the extension was created.
    extended_at: ?i64 = null,

    /// The payment processing status of the extension.
    payment_status: ?[]const u8 = null,

    /// The start date of the extension period.
    start_date: ?i64 = null,

    /// The current status of the extension (e.g., Pending, Active, Scheduled,
    /// Failed, Expired).
    status: ?[]const u8 = null,

    /// The unique identifier of the extension offering that was used to create this
    /// extension.
    training_plan_extension_offering_id: []const u8,

    /// The upfront fee for the extension.
    upfront_fee: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .availability_zone_id = "AvailabilityZoneId",
        .currency_code = "CurrencyCode",
        .duration_hours = "DurationHours",
        .end_date = "EndDate",
        .extended_at = "ExtendedAt",
        .payment_status = "PaymentStatus",
        .start_date = "StartDate",
        .status = "Status",
        .training_plan_extension_offering_id = "TrainingPlanExtensionOfferingId",
        .upfront_fee = "UpfrontFee",
    };
};
