/// The action to perform on findings that match the filter criteria. To
/// suppress (automatically archive) findings that match the criteria, set this
/// value to ARCHIVE. Valid values are:
pub const FindingsFilterAction = enum {
    archive,
    noop,

    pub const json_field_names = .{
        .archive = "ARCHIVE",
        .noop = "NOOP",
    };
};
