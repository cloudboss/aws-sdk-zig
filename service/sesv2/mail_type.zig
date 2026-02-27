pub const MailType = enum {
    marketing,
    transactional,

    pub const json_field_names = .{
        .marketing = "MARKETING",
        .transactional = "TRANSACTIONAL",
    };
};
