pub const FolderName = enum {
    inbox,
    deleted_items,
    sent_items,
    drafts,
    junk_email,

    pub const json_field_names = .{
        .inbox = "INBOX",
        .deleted_items = "DELETED_ITEMS",
        .sent_items = "SENT_ITEMS",
        .drafts = "DRAFTS",
        .junk_email = "JUNK_EMAIL",
    };
};
