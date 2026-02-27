/// The timeline of the cluster step lifecycle.
pub const StepTimeline = struct {
    /// The date and time when the cluster step was created.
    creation_date_time: ?i64,

    /// The date and time when the cluster step execution completed or failed.
    end_date_time: ?i64,

    /// The date and time when the cluster step execution started.
    start_date_time: ?i64,

    pub const json_field_names = .{
        .creation_date_time = "CreationDateTime",
        .end_date_time = "EndDateTime",
        .start_date_time = "StartDateTime",
    };
};
