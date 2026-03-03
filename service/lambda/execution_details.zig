/// Details about a [durable
/// execution](https://docs.aws.amazon.com/lambda/latest/dg/durable-functions.html).
pub const ExecutionDetails = struct {
    /// The original input payload provided for the durable execution.
    input_payload: ?[]const u8 = null,

    pub const json_field_names = .{
        .input_payload = "InputPayload",
    };
};
