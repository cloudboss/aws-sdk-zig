/// Represents the progress of an online resharding operation.
pub const SlotMigration = struct {
    /// The percentage of the slot migration that is complete.
    progress_percentage: f64 = 0,

    pub const json_field_names = .{
        .progress_percentage = "ProgressPercentage",
    };
};
