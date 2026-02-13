pub const MessageSystemAttributeNameForSends = enum {
    aws_trace_header,

    pub const json_field_names = .{
        .aws_trace_header = "AWSTraceHeader",
    };
};
