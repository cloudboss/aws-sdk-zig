pub const ImageStateChangeReasonCode = enum {
    internal_error,
    image_builder_not_available,
    image_copy_failure,
    image_update_failure,
    image_import_failure,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .image_builder_not_available = "IMAGE_BUILDER_NOT_AVAILABLE",
        .image_copy_failure = "IMAGE_COPY_FAILURE",
        .image_update_failure = "IMAGE_UPDATE_FAILURE",
        .image_import_failure = "IMAGE_IMPORT_FAILURE",
    };
};
