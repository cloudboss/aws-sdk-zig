pub const DataSourceStatus = enum {
    available,
    deleting,
    delete_unsuccessful,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .deleting = "DELETING",
        .delete_unsuccessful = "DELETE_UNSUCCESSFUL",
    };
};
