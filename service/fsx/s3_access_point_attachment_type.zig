pub const S3AccessPointAttachmentType = enum {
    openzfs,
    ontap,

    pub const json_field_names = .{
        .openzfs = "OPENZFS",
        .ontap = "ONTAP",
    };
};
