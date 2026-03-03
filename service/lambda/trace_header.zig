/// Contains trace headers for the Lambda durable execution.
pub const TraceHeader = struct {
    /// The X-Ray trace header associated with the durable execution.
    x_amzn_trace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .x_amzn_trace_id = "XAmznTraceId",
    };
};
