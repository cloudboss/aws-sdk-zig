pub const PostContactSummaryStatus = enum {
    failed,
    completed,

    pub const json_field_names = .{
        .failed = "FAILED",
        .completed = "COMPLETED",
    };
};
