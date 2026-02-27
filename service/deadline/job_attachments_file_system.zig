pub const JobAttachmentsFileSystem = enum {
    copied,
    virtual,

    pub const json_field_names = .{
        .copied = "COPIED",
        .virtual = "VIRTUAL",
    };
};
