/// The tag type that AWS Billing and Cost Management will use to sort your AWS
/// Elemental MediaConvert costs on any billing report that you set up.
pub const BillingTagsSource = enum {
    queue,
    preset,
    job_template,
    job,

    pub const json_field_names = .{
        .queue = "QUEUE",
        .preset = "PRESET",
        .job_template = "JOB_TEMPLATE",
        .job = "JOB",
    };
};
