pub const SSEType = enum {
    sse_ebs,
    sse_kms,
    none,

    pub const json_field_names = .{
        .sse_ebs = "SSE_EBS",
        .sse_kms = "SSE_KMS",
        .none = "NONE",
    };
};
