/// The timeline of the instance group lifecycle.
pub const InstanceGroupTimeline = struct {
    /// The creation date and time of the instance group.
    creation_date_time: ?i64,

    /// The date and time when the instance group terminated.
    end_date_time: ?i64,

    /// The date and time when the instance group became ready to perform tasks.
    ready_date_time: ?i64,

    pub const json_field_names = .{
        .creation_date_time = "CreationDateTime",
        .end_date_time = "EndDateTime",
        .ready_date_time = "ReadyDateTime",
    };
};
