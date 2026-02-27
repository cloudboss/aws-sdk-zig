/// Contains any warning codes and their count for the job.
pub const WarningGroup = struct {
    /// Warning code that identifies a specific warning in the job. For more
    /// information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/warning_codes.html
    code: i32,

    /// The number of times this warning occurred in the job.
    count: i32,

    pub const json_field_names = .{
        .code = "Code",
        .count = "Count",
    };
};
