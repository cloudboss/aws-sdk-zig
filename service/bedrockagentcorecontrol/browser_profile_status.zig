/// The status of a browser profile.
pub const BrowserProfileStatus = enum {
    ready,
    deleting,
    deleted,
    saving,

    pub const json_field_names = .{
        .ready = "READY",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .saving = "SAVING",
    };
};
