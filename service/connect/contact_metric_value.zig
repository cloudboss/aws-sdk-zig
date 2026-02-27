/// Contains the numeric value of a contact metric result.
pub const ContactMetricValue = union(enum) {
    /// The numeric value of the metric result. For POSITION_IN_QUEUE, this
    /// represents the contact's
    /// current position in the queue (e.g., 3.00 means third in line). For
    /// ESTIMATED_WAIT_TIME, this represents
    /// the predicted wait time in seconds (e.g., 120.00 means approximately 2
    /// minutes).
    number: ?f64,

    pub const json_field_names = .{
        .number = "Number",
    };
};
