pub const ActionCode = enum {
    archive_retrieval,
    inventory_retrieval,
    select,

    pub const json_field_names = .{
        .archive_retrieval = "ArchiveRetrieval",
        .inventory_retrieval = "InventoryRetrieval",
        .select = "Select",
    };
};
