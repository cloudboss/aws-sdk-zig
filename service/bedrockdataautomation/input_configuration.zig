const InlinePayload = @import("inline_payload.zig").InlinePayload;
const S3Object = @import("s3_object.zig").S3Object;

/// Input configuration for DataAutomationLibraryIngestionJob
pub const InputConfiguration = struct {
    /// Input Payload
    inline_payload: ?InlinePayload = null,

    /// S3 object
    s_3_object: ?S3Object = null,

    pub const json_field_names = .{
        .inline_payload = "inlinePayload",
        .s_3_object = "s3Object",
    };
};
