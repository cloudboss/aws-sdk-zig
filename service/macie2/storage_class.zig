/// The storage class of the S3 object. Possible values are:
pub const StorageClass = enum {
    standard,
    reduced_redundancy,
    standard_ia,
    intelligent_tiering,
    deep_archive,
    onezone_ia,
    glacier,
    glacier_ir,
    outposts,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .reduced_redundancy = "REDUCED_REDUNDANCY",
        .standard_ia = "STANDARD_IA",
        .intelligent_tiering = "INTELLIGENT_TIERING",
        .deep_archive = "DEEP_ARCHIVE",
        .onezone_ia = "ONEZONE_IA",
        .glacier = "GLACIER",
        .glacier_ir = "GLACIER_IR",
        .outposts = "OUTPOSTS",
    };
};
