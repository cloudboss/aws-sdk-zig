pub const ImageState = enum {
    pending,
    available,
    invalid,
    deregistered,
    transient,
    failed,
    @"error",
    disabled,
};
