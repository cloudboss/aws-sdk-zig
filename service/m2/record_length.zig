/// The length of the records in the data set.
pub const RecordLength = struct {
    /// The maximum record length. In case of fixed, both minimum and maximum are
    /// the
    /// same.
    max: i32 = 0,

    /// The minimum record length of a record.
    min: i32 = 0,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};
