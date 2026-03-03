/// The timeline of the instance lifecycle.
pub const InstanceTimeline = struct {
    /// The creation date and time of the instance.
    creation_date_time: ?i64 = null,

    /// The date and time when the instance was terminated.
    end_date_time: ?i64 = null,

    /// The date and time when the instance was ready to perform tasks.
    ready_date_time: ?i64 = null,

    pub const json_field_names = .{
        .creation_date_time = "CreationDateTime",
        .end_date_time = "EndDateTime",
        .ready_date_time = "ReadyDateTime",
    };
};
