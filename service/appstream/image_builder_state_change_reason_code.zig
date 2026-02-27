pub const ImageBuilderStateChangeReasonCode = enum {
    internal_error,
    image_unavailable,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .image_unavailable = "IMAGE_UNAVAILABLE",
    };
};
