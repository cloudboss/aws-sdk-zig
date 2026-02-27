/// The destination of the import job, which can be used to list import jobs
/// that have a
/// certain `ImportDestinationType`.
pub const ImportDestinationType = enum {
    suppression_list,
    contact_list,

    pub const json_field_names = .{
        .suppression_list = "SUPPRESSION_LIST",
        .contact_list = "CONTACT_LIST",
    };
};
